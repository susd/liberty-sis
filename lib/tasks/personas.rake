require 'csv'

def progress(i)
  if i % 100 == 0
    print i
  elsif i % 10 == 0
    print '.'
  end
end

namespace :personas do

  task gapps: :environment do
    puts "Google Apps"
    Student.find_each.with_index do |student, idx|
      student.personas.find_or_create_by(handler: "gapps", username: student.persona_email, password: student.persona_init_password)
      progress(idx)
    end
  end

  task pearson: :environment do
    puts "Pearson"
    Student.find_each.with_index do |student, idx|
      student.personas.find_or_create_by(handler: "pearson", username: student.persona_name, password: student.persona_init_password)
      progress(idx)
    end
  end

  task mcgraw: :environment do
    puts "McGraw Hill"
    Student.find_each.with_index do |student, idx|
      student.personas.find_or_create_by(handler: "mcgraw", username: "#{student.persona_name}-susd", password: student.persona_init_password)
      progress(idx)
    end
  end

  task export: :environment do

    fields = [
      'handler',
      'username',
      'password',
      'state',
      'service_id',
      'service_data',
      'synced_at'
    ]

    CSV.open('tmp/data/personas.csv', 'w') do |csv|

      Persona.includes(:student).find_each.with_index do |persona, idx|
        csv << [persona.student.import_details['import_id']] + persona.attributes.slice(*fields).values
        progress(idx)
      end

    end
  end

  task import: :environment do
    CSV.foreach('tmp/data/personas.csv') do |row|
      count = 0
      student = Student.where("import_details -> 'import_id' = ?", row[0]).first
      persona = Persona.find_or_create_by(handler: row[1], username: row[2]) do |p|
        p.student       = student
        p.password      = row[3]
        p.state         = row[4]
        p.service_id    = row[5]
        p.service_data  = JSON.parse(row[6])
        p.synced_at     = DateTime.parse(row[7])
      end
      count += 1
      progress(count)
    end
  end

end
