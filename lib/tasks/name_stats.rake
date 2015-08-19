task name_stats: :environment do

  fname_size = 3
  regex = /(\s|-|\'|\")/

  while fname_size < 24

    puts "Trying #{fname_size}"

    hsh = Hash.new(0)
    Aeries::Student.active.pluck(:fn, :fna, :mn, :ln, :gr).each do |fn, fna, mn, ln, gr|
      middle = (mn.blank? ? '' : mn[0])

      # if fna.blank?
      #   fname = fn[0..fname_size].gsub(regex, '')
      # else
      #   fname = fna.gsub(regex, '')
      # end

      fname = fn[0..fname_size].gsub(regex, '')

      lname = ln.gsub(regex, '')
      grad = (12 - gr) + Time.now.year
      hsh["#{fname}#{middle}#{lname}#{grad.to_s[-2, 2]}"] += 1
    end

    dup_count = hsh.keep_if{|k,v| v > 1}

    # binding.pry

    if dup_count.size == 0
      # binding.pry
      puts "Stopped at #{fname_size}"
      break
    else
      fname_size += 1
    end

  end

end
