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

  task personas: :environment do
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

  end

end
