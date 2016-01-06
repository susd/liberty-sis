require 'csv'

def progress(i)
  if i % 100 == 0
    print i
  elsif i % 10 == 0
    print '.'
  end
end

namespace :bbconnect do
  namespace :export do

    desc "Export Gen Ed students"
    task gen_ed: :environment do
      CSV.open(Bbconnect::K12Exporter::PATH, 'w') do |csv|
        csv << Bbconnect::K12Exporter.header
        Student.includes(:contacts, :site, :grade).order(:site, :grade).find_each.with_index do |student, idx|
          csv << Bbconnect::K12Exporter.new(student).export
          progress(idx)
        end
      end
    end

    desc "Export Ezcare students"
    task ezcare: :environment do
      CSV.open(Bbconnect::CdpExporter::TARGET, 'w') do |csv|
        csv << Bbconnect::CdpExporter.header
        CSV.foreach(Bbconnect::CdpExporter::SOURCE, headers: true).with_index do |row, idx|
          csv << Bbconnect::K12Exporter.new(row).export
          progress(idx)
        end
      end
    end

  end
end
