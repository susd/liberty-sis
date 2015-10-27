require 'csv'

def progress(i)
  if i % 100 == 0
    print i
  elsif i % 10 == 0
    print '.'
  end
end

namespace :report_cards do

  task import_all: :environment do
    Site.all.each do |site|
      puts site.name
      count = 0
      site.classrooms.includes(:students).each do |classroom|
        print classroom.name
        classroom.students.each do |student|
          Ischool::ReportCardImporter.all_for_student(student)
          count += 1
          progress(count)
        end
      end
    end
  end

  task import_json: :environment do
    path = Rails.root.join('tmp', 'data', 'rc_export')
    files = Dir["#{path}/*.json"]
    errors = []
    files.each_with_index do |f, idx|
      if ReportCards::JsonImporter.new(f).import!
        progress(idx)
      else
        errors << f
        print 'E'
      end
    end
  end

  namespace :comments do

    task export: :environment do
      CSV.open('tmp/data/rc/comments.csv', 'w') do |csv|
        count = 0
        csv << ['form_name', 'group_name', 'english', 'spanish']

        ReportCard::Comment.includes(:comment_group).all.each do |comment|
          row = []
          row << comment.comment_group.form.renderer
          row << comment.comment_group.name
          row << comment.english
          row << comment.spanish
          csv << row

          count += 1
          progress(count)
        end
      end
    end

    task import: :environment do
      raise RuntimeError, "No forms" unless ReportCard::Form.any?

      count = 0
      CSV.foreach('tmp/data/rc/comments.csv') do |row|
        if form = ReportCard::Form.find_by(renderer: row[0])
          group = ReportCard::CommentGroup.find_or_create_by(name: row[1], form: form)

          unless comment = group.comments.find_by(english: row[2])
            group.comments.create(english: row[2], spanish: row[3])
          end

          count += 1
          progress(count)
        end
      end
    end

  end

  namespace :subjects do
    task export: :environment do
      fields = [
        'name',
        'spanish_name',
        'major',
        'position',
        'show_score',
        'positional_score',
        'show_effort',
        'show_level','slug',
        'side_section'
      ]

      CSV.open('tmp/data/rc/subjects.csv', 'w') do |csv|
        count = 0
        header = (['form_name'] + fields)
        csv << header

        ReportCard::Form.all.each do |form|
          form.subjects.each do |subject|
            csv << ([form.name] + subject.attributes.slice(*fields).values)
            count += 1
            progress(count)
          end
        end
      end
    end

    task import: :environment do
      raise RuntimeError, "No forms" unless ReportCard::Form.any?

      count = 0
      CSV.foreach('tmp/data/rc/subjects.csv') do |row|
        if form = ReportCard::Form.find_by(name: row[0])
          subject = form.subjects.where(name: row[1]).first_or_create({
            spanish_name: row[2], major: row[3], position: row[4],
            show_score: row[5], positional_score: row[6], show_effort: row[7],
            show_level: row[8], slug: row[9], side_section: row[10]
          })

          count += 1
          progress(count)
        end
      end
    end #/task
  end

end
