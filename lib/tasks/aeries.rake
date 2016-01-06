def progress(i)
  if i % 100 == 0
    print i
  elsif i % 10 == 0
    print '.'
  end
end

namespace :aeries do

  task deactivate: :environment do
    Aeries::Student.inactive.find_each.with_index do |stu, idx|
      Aeries::StudentImporter.new(stu).import!
      progress(idx)
    end
  end

  task contacts: :environment do
    Student.order(:site).find_each.with_index do |student, idx|
      Aeries::SyncContactsJob.set(wait_until: 8.hours.ago).perform_later(student)
      progress(idx)
    end
  end

end
