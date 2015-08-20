require 'csv'

def progress(i)
  if i % 100 == 0
    print i
  elsif i % 10 == 0
    print '.'
  end
end

namespace :renplace do

  task export: :environment do

    rp_sites = Setting.find_by(name: 'renplace_sites').data

    header = %w{SID SFirst SLast SBirthday SGrade SUsername SPassword}

    rp_sites.each do |site_id|
      site = Site.find(site_id)
      puts site.name
      CSV.open("tmp/data/rp-#{site.abbr}-#{Time.now.strftime('%Y%m%d')}.csv", 'w') do |csv|
        csv << header
        Student.where(site_id: site_id).find_each.with_index do |student, idx|
          csv << RpExporter.new(student).export
          progress(idx)
        end
      end
    end

  end

end
