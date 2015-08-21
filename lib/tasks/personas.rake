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

  task update: :environment do
    Student.find_each.with_index do |student, idx|
      p = student.personas.find_by(handler: "gapps")
      if p && p.username != student.persona_email
        p.update(username: student.persona_email)
      end
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
      student = Student.find_by("import_details -> 'import_id' = ?", row[0].to_s)
      persona = Persona.find_or_create_by(handler: row[1], username: row[2]) do |p|
        p.student       = student
        p.password      = row[3]
        p.state         = Persona.states.invert[row[4].to_i]
        p.service_id    = row[5]
        p.service_data  = JSON.parse(row[6])
        p.synced_at     = (row[7].blank? ? nil : DateTime.parse(row[7]))
      end
      count += 1
      progress(count)
    end
  end

  task verify: :environment do
    Student.where(grade: Grade.where("position > 1.0")).find_each.with_index do |student, idx|
      VerifyGappsPersonaJob.perform_later(student)
      progress(idx)
    end
  end

  task cleanup: :environment do
    crit = Student.where(grade: Grade.where("position > 1.0")).where("length(first_name) > 5")
    crit.find_each.with_index do |student, idx|
      CleanGappsPersonaJob.perform_later(student)
      progress(idx)
    end
  end

end
