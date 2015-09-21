require 'csv'
require 'fileutils'

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

def prepare(path)
  FileUtils.mkdir_p(path)
end

namespace :mcgraw do

  namespace :personas do

    task students: :environment do
      puts "McGraw Hill"
      Student.active.find_each.with_index do |student, idx|
        persona = student.personas.find_by(handler: 'mcgraw', username: "#{student.persona_name}-susd")
        if persona.nil?
          student.personas.create({
            handler: 'mcgraw',
            username: "#{student.persona_name}-susd",
            password: student.persona_init_password,
            service_id: student.import_details['import_id']
            })
        end
        progress(idx)
      end
    end

  end

  namespace :export do

    task classes: :environment do

      prefix = "tmp/data/mcgraw"
      Site.order(:code).each do |site|
        puts site.name
        dir = "#{prefix}/#{stamp}/#{site.abbr}"
        prepare(dir)
        site.employees.where(type: 'Teacher').distinct.each do |teacher|
          print "#{teacher.persona_name} "
          path = "#{dir}/#{teacher.persona_name}.xls"
          # CSV.open(path, 'w') do |csv|
          #   csv << Mcgraw::ClassExporter.header
          #   Mcgraw::ClassExporter.new(teacher).export_to(csv)
          # end
          writter = Mcgraw::Formatter.new(path)
          writter.write do |sheet|
            sheet.insert_row(0, Mcgraw::ClassExporter.header)
            Mcgraw::ClassExporter.new(teacher).rows.each_with_index do |student, idx|
              sheet.insert_row(idx+1, student)
            end
          end
        end
        puts "\n"
      end

    end

  end

end
