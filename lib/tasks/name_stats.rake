namespace :stats do

  task students: :environment do

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

  task teachers: :environment do

    fname_size = 5
    lname_size = 18

    hsh = Hash.new(0)

    Teacher.find_each do |teacher|
      name = (teacher.first_name[0...fname_size] + teacher.lastest_name[0...lname_size]).gsub(/(\s|-|\'|\")/, '')
      hsh[name] += 1
    end

    dups = hsh.dup.keep_if{|k,v| v > 1}

    shorts = hsh.find_all{|k,v| k.length < 8}

    longs = hsh.find_all{|k,v| k.length > 14}

    puts dups
    puts shorts.map(&:first)
    puts longs.map(&:first)

  end

end
