class ReportCard::Presenter < BasePresenter
  presents :report_card

  def subjects
    report_card.form.subjects.order(:position)
  end

  def get_subject(subject, subject_key, period)
    report_card.fetch_data(['subjects', subject.id.to_s, 'periods', period.to_s, subject_key])
  end

  def get_level(subject, period)
    report_card.fetch_data(['subjects', subject.id.to_s, 'periods', period.to_s, 'level'])
  end

  def comment_ids
    cmnts = []
    (1..3).each do |i|
      cmnts << report_card.comment_data(i)
    end
    cmnts.flatten.uniq
  end

  def comment_periods
    (1..3).inject({}) do |result, period|
      if report_card.has_comments?(period)
        result.merge!( period => ReportCard::Comment.find( report_card.comment_data(period)) )
      end
      result
    end
  end

  def positional_value_tag(subject, period)
    tpl.capture do
      %w{R W D}.each_with_index do |v, idx|
        classes = ['pos_score-value']
        classes << 'selected' if handle_string_score(get_subject(subject, 'score', period)) == idx
        tpl.concat content_tag :span, v, class: classes.join(' ')
      end
    end
  end

  def handle_string_score(score)
    if score.blank?
      nil
    else
      score.to_i
    end
  end

  def attendance
    report_card.fetch_data(['attendance'])
  end

  def absences(period)
    report_card.fetch_data(['attendance', period.to_s, 'absences'])
  end

  def tardies(period)
    report_card.fetch_data(['attendance', period.to_s, 'tardies'])
  end

  def editable?
    report_card.year == SchoolYear.this_year
  end

  def attendance_updated_at
    # if editable?
    #   last_sync = SyncEvent.where(label: 'attendance:recent').maximum(:updated_at) || Attendance.maximum(:updated_at)
    #   time_ago_in_words last_sync
    # end
    time_ago_in_words report_card.updated_at
  end

  def value_form?
    report_card.form.renderer == 'upper'
  end

end
