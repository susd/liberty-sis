require 'csv'
require 'fileutils'

def progress(i)
  if i % 100 == 0
    print i
  elsif i % 10 == 0
    print '.'
  end
end

def prepare(path)
  FileUtils.mkdir_p(path)
end

namespace :caaspp do
  task import: :environment do
    path = Rails.root.join('tmp', 'data', 'caaspp')
    files = Dir["#{path}/**/*.csv"]

    files.each do |file|
      puts file
      CSV.foreach(file, headers: true).with_index do |row, idx|
        if Caaspp::IabImporter.new(row).import
          progress(idx)
        else
          puts "E#{row['StudentIdentifier']}"
        end
      end
    end
  end

  #FIXME: Don't assume all assessments are the same
  task export: :environment do
    path_prefix = Rails.root.join('tmp', 'data', 'caaspp', 'export')
    Site.order(:abbr).each do |site|
      site.classrooms.includes({home_students: :assessments}, :primary_teacher).each_with_index do |classroom, idx|
        dir = path_prefix.join(site.abbr)
        prepare(dir)
        path = dir.join("#{classroom.name.parameterize}.csv")
        CSV.open(path, 'wb') do |csv|
          csv << Caaspp::IabExporter.header
          classroom.home_students.order(:last_name).each do |student|
            student.assessments.each do |a|
              csv << Caaspp::IabExporter.new(a).export
            end
          end
        end
        progress(idx)
      end
    end

  end
end
