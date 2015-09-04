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

namespace :typing do

  namespace :personas do

    task students: :environment do
      Student.order(:site_id, :grade_id).find_each.with_index do |student, idx|
        student.personas.find_or_create_by(handler: 'typing_club', username: student.persona_name) do |p|
          p.password = student.persona_init_password
          p.service_data = {student_id: student.import_details['import_id']}
        end
        progress(idx)
      end
    end

    task teachers: :environment do
      Teacher.find_each.with_index do |teacher, idx|
        teacher.personas.find_or_create_by(handler: 'typing_club', username: teacher.persona_name) do |p|
          p.password = teacher.persona_init_password
          p.service_id = teacher.import_details['import_id']
        end
        progress(idx)
      end
    end

  end

  namespace :export do

    task students: :environment do
      path = "tmp/data/typing/students-#{stamp}.csv"

      CSV.open(path, 'w') do |csv|
        csv << TypingClub::StudentExporter.header
        Student.includes(:site, :personas).order(:site_id, :grade_id).find_each.with_index do |student, idx|
          csv << TypingClub::StudentExporter.new(student).export
          progress(idx)
        end
      end
    end

    task teachers: :environment do
      path = "tmp/data/typing/teachers-#{stamp}.csv"

      CSV.open(path, 'w') do |csv|
        csv << TypingClub::TeacherExporter.header
        Site.order(:code).each do |site|
          puts site.name
          site.teachers.includes(:personas).find_each.with_index do |teacher, idx|
            csv << TypingClub::TeacherExporter.new(teacher).export
            progress(idx)
          end
          puts "\n"
        end
      end
    end

    task classes: :environment do
      path = "tmp/data/typing/classes-#{stamp}.csv"

      CSV.open(path, 'w') do |csv|
        csv << TypingClub::ClassExporter.header
        Site.order(:code).each do |site|
          puts site.name
          site.classrooms.each do |classroom|
            puts classroom.name
            csv << TypingClub::ClassExporter.new(classroom).export
          end
          puts "\n"
        end
      end
    end

  end

end
