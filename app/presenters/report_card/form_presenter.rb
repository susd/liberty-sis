class ReportCard::FormPresenter < BasePresenter
  presents :report_card

  def form_tag(student, &block)
    tpl.bootstrap_form_tag({url: student_report_card_path(student, report_card), method: :put, html: {class: 'form-affixed_actions'}}, &block)
  end

  def text_field(builder, field_name, options = {})
    builder.text_field field_name, options
  end

  def subject_field(builder, subject, subject_key, period = 1, options = {})
    field_name = "report_card[data][subjects][#{subject.id}][periods][#{period}][#{subject_key}]"
    opts = field_defaults(subject_key).merge(options)
    if report_card.has_subject?(period, subject)
      stored_value = report_card.fetch_data(['subjects', subject.id.to_s, 'periods', period.to_s, subject_key])
      unless stored_value.blank?
        opts.merge!(value: stored_value)
      end
    end
    text_field( builder, field_name, opts )
  end

  def comment_box(comment, period = 1, options = {})
    field_name = "report_card[data][comments][#{period}][comment_ids][]"
    defaults = {
      id: dom_id(comment)
    }
    if report_card.has_comments?(period)
      ids = report_card.fetch_data(['comments',period.to_s,'comment_ids']).map(&:to_i)
    else
      ids = []
    end
    value = ids.include?(comment.id)
    check_box_tag field_name, comment.id, value
  end

  def render_comments(builder, comment_group)
    locals = {
      f: builder,
      resource: report_card,
      comment_group: comment_group,
      presenter: self
    }
    tpl.render partial: "report_cards/comment_groups/checkboxes", locals: locals
  end

  def positional_score(builder, subject, period)
    %w{R W D}.each_with_index do |label, score|
      yield(position_radio_for(builder, subject, period, score), label)
    end
  end

  def partial_locals(builder)
    {
      builder: builder,
      report_card: report_card,
      subjects: card_subjects,
      presenter: self
    }
  end

  def card_subjects
    report_card.form.subjects.order(:position)
  end

  def instruction_level(subject)
    report_card.student.grade.simple
  end

  def positional_form?
    !value_form?
  end

  def value_form?
    report_card.form.renderer == 'upper'
  end

  def next_grade_field(builder)
    next_grade = report_card.fetch_data(['next_grade']) || report_card.student.try(:grade).try(:succ).try(:name)
    builder.text_field("report_card[data][next_grade]", label: 'Next Grade', value: next_grade)
  end

  def teacher_name_field(builder)
    name = report_card.fetch_data(['teacher_name']) || report_card.student.homeroom.primary_teacher.try(:name)
    builder.text_field("report_card[data][teacher_name]", label: 'Teacher Name', value: name)
  end

  private

  def position_radio_for(builder, subject, period, score)
    field_name = "report_card[data][subjects][#{subject.id}][periods][#{period}][score]"

    tpl.radio_button_tag(field_name, score, position_checked?(subject, period, score))
  end

  def field_defaults(placeholder = nil)
    {
      hide_label: true,
      placeholder: placeholder
    }
  end

  def position_checked?(subject, period, score)
    report_card.fetch_data(['subjects', subject.id.to_s, 'periods', period.to_s, 'score']).to_s == score.to_s
  end

end
