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

namespace :scholastic do

  namespace :personas do
    task students: :environment do
      sites = Site.where(id: Setting.find_by(name: 'scholastic_sites').data)
      Student.where(site: sites).find_each.with_index do |student, idx|
        student.personas.find_or_create_by({
          handler: 'scholastic',
          username: student.persona_name,
          password: student.persona_init_password,
          service_id: student.import_details['import_id']
          })
        progress(idx)
      end
    end
  end

  namespace :export do

    task teachers: :environment do
      sites = Site.where(id: Setting.find_by(name: 'scholastic_sites').data)
      sites.order(:code).each do |site|
        CSV.open("tmp/data/sch-#{site.abbr}-teachers-#{stamp}.csv", 'w') do |csv|
          csv << Scholastic::TeacherExporter.header
          site.employees.where(type: 'Teacher').find_each.with_index do |teacher, idx|
            csv << Scholastic::TeacherExporter.new(teacher, site).export
            progress(idx)
          end
        end
      end
    end

    task students: :environment do
      sites = Site.where(id: Setting.find_by(name: 'scholastic_sites').data)

      CSV.open("tmp/data/sch-students-#{stamp}.csv", 'w') do |csv|
        csv << Scholastic::StudentExporter.header
        Student.includes(:homeroom, :site).where(site: sites).order(:site_id).find_each.with_index do |student, idx|
          csv << Scholastic::StudentExporter.new(student).export
          progress(idx)
        end
      end
    end

  end

end
