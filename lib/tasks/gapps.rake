require 'csv'

def progress(i)
  if i % 100 == 0
    print i
  elsif i % 10 == 0
    print '.'
  end
end

namespace :gapps do

  namespace :personas do

    task students: :environment do
      puts "Google Apps"
      Student.find_each.with_index do |student, idx|
        # student.personas.find_or_create_by(handler: "gapps", username: student.persona_email, password: student.persona_init_password)
        if persona = student.personas.find_by(handler: 'gapps', username: student.persona_email)
          persona.update(password: student.persona_init_password)
        else
          if Persona.where(handler: 'gapps', username: student.persona_email).where.not(personable: student).exists?
            print "#{student.id} "
          end
          student.personas.create(handler: "gapps", username: student.persona_email, password: student.persona_init_password)
        end
        progress(idx)
      end
    end

  end

end
