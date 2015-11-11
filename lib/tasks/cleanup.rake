def progress(i)
  if i % 100 == 0
    print i
  elsif i % 10 == 0
    print '.'
  end
end

namespace :cleanup do

  task bad_aliases: :environment do

    # Page through users, collect ids
    service = Gapps::Base.service

    ids = Set.new

    prev_page = service.list_users(customer: 'my_customer')

    prev_page.users.each{|u| ids << u.id }

    page_count = 1

    loop do
      print " #{page_count} "
      next_page = service.list_users(customer: 'my_customer', max_results: 500, page_token: prev_page.next_page_token)

      next_page.users.each{|u| ids << u.id }

      if next_page.next_page_token.nil?
        break
      else
        prev_page = next_page
        page_count += 1
      end
    end

    puts "Creating #{ids.count} jobs"

    ids.each_with_index do |i, idx|
      CleanGappsAliasJob.perform_later(i)
      print '.' if idx % 10 == 0
    end

  end

  task inactive_personas: :environment do
    Student.inactive.find_each do |student|
      student.personas.destroy_all
    end
  end

  task dup_personas: :environment do
    site = Site.find_by(code: 75)
    dups = site.students.active.includes(:personas).map do |student|
      if student.personas.where(handler: 'gapps').count > 1
        student.personas.where(handler: 'gapps').order(:created_at).last
      end
    end

    dups.each_with_index do |persona, idx|
      DeleteGappsPersonaJob.perform_later(persona)
      progress(idx)
    end
  end

  task reset_attendance: :environment do
    puts "Clearing attendance"
    Attendance.destroy_all

    puts "Reimporting"
    Student.find_each.with_index do |student, idx|
      if a = student.aeries_student
        Aeries::AttendanceImporter.new(a).import!
      end
      progress(idx)
    end

    puts "Updating cards"
    ReportCard.where(student_id: nil).destroy_all
    ReportCard.find_each.with_index do |card, idx|
      card.update_attendance
      card.save
      progress(idx)
    end
  end

end
