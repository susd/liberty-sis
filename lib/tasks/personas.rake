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

      Persona.includes(:personable).find_each.with_index do |persona, idx|
        csv << [persona.personable_type, persona.personable.import_details['import_id']] + persona.attributes.slice(*fields).values
        progress(idx)
      end

    end
  end

  task import: :environment do
    count = 0
    CSV.foreach('tmp/data/personas.csv') do |row|
      # student = Student.find_by("import_details -> 'import_id' = ?", row[0].to_s)
      personable = row[0].constantize.find_by(["import_details -> 'import_id' = ?", row[1].to_s])
      persona = Persona.find_or_create_by(handler: row[2], username: row[3]) do |p|
        p.personable    = personable
        p.password      = row[4]
        p.state         = Persona.states.invert[row[5].to_i]
        p.service_id    = row[6]
        # p.service_data  = JSON.parse(row[7])
        p.service_data  = eval %Q[#{row[7]}]
        p.synced_at     = (row[8].blank? ? nil : DateTime.parse(row[8]))
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
