require 'csv'

def progress(i)
  if i % 100 == 0
    print i
  elsif i % 10 == 0
    print '.'
  end
end

namespace :pearson do
  task student_personas: :environment do
    puts "pearson"

    Student.find_each.with_index do |student, idx|
      student.personas.find_or_create_by(handler: 'pearson', username: student.persona_name, password: student.persona_init_password)
      progress(idx)
    end
  end

  namespace :export do

    task teachers: :environment do
      stamp = Time.now.strftime('%Y%m%d')
      Site.order(:code).each do |site|
        CSV.open("tmp/data/psn-#{site.abbr}-teachers-#{stamp}.csv", 'w') do |csv|
          csv << Pearson::TeacherExporter.header
          site.employees.where(type: 'Teacher').find_each.with_index do |teacher, idx|
            csv << Pearson::TeacherExporter.new(teacher).export
            progress(idx)
          end
        end
      end
    end

  end

end
