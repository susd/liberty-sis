def progress(i)
  if i % 100 == 0
    print i
  elsif i % 10 == 0
    print '.'
  end
end

def default_persona(student, handler)

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

end
