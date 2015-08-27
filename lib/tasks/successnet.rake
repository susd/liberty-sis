require 'csv'

def progress(i)
  if i % 100 == 0
    print i
  elsif i % 10 == 0
    print '.'
  end
end

def stamp
  Time.now.strftime('%Y%m%d')
end

namespace :successnet do

  namespace :personas do

    task students: :environment do
      Student.find_each.with_index do |student, idx|
        student.personas.find_or_create_by({
          handler: 'successnet',
          username: student.persona_name,
          password: student.persona_init_password,
          service_id: student.import_details['import_id']
          })
        progress(idx)
      end
    end

    task teachers: :environment do
      Teacher.find_each.with_index do |teacher, idx|
        teacher.personas.find_or_create_by({
          handler: 'successnet',
          username: teacher.persona_name,
          password: teacher.persona_init_password,
          service_id: teacher.import_details['import_id']
          })
        progress(idx)
      end
    end

  end

  namespace :export do

    task students: :environment do
      prefix = "tmp/data/successnet"
      Site.order(:code).each do |site|
        path = "#{prefix}/students-#{site.abbr}-#{stamp}.txt"
        Pearson::SuccessNet::Formatter.write(path) do |f|
          f.puts Pearson::SuccessNet::StudentExporter.header
          site.students.find_each.with_index do |student, idx|
            f.puts Pearson::SuccessNet::StudentExporter.new(student).export.join("\t")
            progress(idx)
          end
        end
      end
    end

    task teachers: :environment do
      prefix = "tmp/data/successnet"
      Site.order(:code).each do |site|
        path = "#{prefix}/teachers-#{site.abbr}-#{stamp}.txt"
        Pearson::SuccessNet::Formatter.write(path) do |f|
          f.puts Pearson::SuccessNet::TeacherExporter.header
          site.employees.where(type: 'Teacher').find_each.with_index do |teacher, idx|
            f.puts Pearson::SuccessNet::TeacherExporter.new(teacher).export.join("\t")
            progress(idx)
          end
        end
      end
    end

    # SuccessNet Roster is uploaded through EasyBridge so it's csv

    task rosters: :environment do
      prefix = "tmp/data/successnet"
      Site.order(:code).each do |site|
        puts site.name
        path = "#{prefix}/rosters-#{site.abbr}-#{stamp}.csv"
        CSV.open(path, 'w') do |csv|
          csv << Pearson::SuccessNet::RosterExporter.header
          site.employees.where(type: 'Teacher').each do |teacher|
            print "#{teacher.persona_name} "
            Pearson::SuccessNet::RosterExporter.new(teacher).export_to(csv)
          end

          puts "\n"
        end
      end
    end

  end

end
