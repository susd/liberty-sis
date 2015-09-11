namespace :cleanup do

  task bad_aliases: :environment do

    # Page through users, collect ids
    service = Gapps::Base.service

    ids = Set.new

    prev_page = service.list_users(customer: 'my_customer')

    prev_page.users.each{|u| ids << u.id }

    page_count = 1

    loop do
      print " #{page_count} "
      next_page = service.list_users(customer: 'my_customer', max_results: 500, page_token: prev_page.next_page_token)

      next_page.users.each{|u| ids << u.id }

      if next_page.next_page_token.nil?
        break
      else
        prev_page = next_page
        page_count += 1
      end
    end

    puts "Creating #{ids.count} jobs"

    ids.each_with_index do |i, idx|
      CleanGappsAliasJob.perform_later(i)
      print '.' if idx % 10 == 0
    end

  end

end
