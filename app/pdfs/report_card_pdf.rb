require 'pdf_report_card'

class ReportCardPdf

  WHITE = 'F'  * 6
  BLACK = '3'  * 6
  DGREY = 'A'  * 6
  GREY  = 'E1' * 3

  def data
    @data ||= collate_data
  end

  private

  def collate_data
    data = {
      'name'        => student.name,
      'year'        => ReportCard::GradingPeriod.school_year,
      'school'      => student.site.name,
      'teacher'     => teacher_name,
      'principal'   => student.site.principal,
      'next_grade'  => @report_card.fetch_data(['next_grade']),
      'comments'    => {},
      'spanish_comments' => {}
    }

    data['main_subjects'] = tabulate_subjects(main_subjects)
    data['side_subjects'] = tabulate_subjects(side_subjects, 3)

    data['attendance'] = tabulate_attendance

    @report_card.fetch_data['comments'].each do |period, values|
      data['comments'][period] = ReportCard::Comment.find(values['comment_ids']).map(&:english)
    end

    if student.home_lang.name == "Spanish"
      data['spanish_main'] = tabulate_subjects(main_subjects, 12, :spanish)
      data['spanish_side'] = tabulate_subjects(side_subjects, 3, :spanish)

      @report_card.fetch_data['comments'].each do |period, values|
        data['spanish_comments'][period] = ReportCard::Comment.find(values['comment_ids']).map(&:spanish)
      end

      data['spanish_attendance'] = tabulate_attendance(:spanish)
    end

    data
  end

  def tabulate_subjects(subjects, columns = 12, lang = :english)
    result = []

    subjects.each do |subject|

      if subject.show_level?
        # do major with level
        level_arr = [{content: title_for(subject, lang).mb_chars.upcase.to_s, font: PdfReportCard::DEFAULT_BOLD_FONT}]
        level_arr += fetch(['subjects', subject.id.to_s, 'periods']).flat_map do |p, pdata|
          [
            {content: "Instructional Level: #{pdata['level']}", colspan: (columns/3) - 1},
            {content: pdata['effort']}
          ]
        end
        result << level_arr
      else
        result << subject_array(subject, columns, lang)
      end

    end
    result
  end

  def tabulate_attendance(lang = :english)
    @att_hsh ||= student.attendance_by_type
    abs_title = (lang == :english ? "Days Absent" : "Días Ausente")
    tar_title = (lang == :english ? "Days Tardy" : "Días Tarde")
    [
      [abs_title, @att_hsh[:absences]].flatten,
      [tar_title, @att_hsh[:tardies]].flatten
    ]
  end

  # Build an array of subject marks
  # If this is a long row (6 columns) then
  # fill all six columns, accounting for
  # subjects that don't show scores.
  # Otherwise the array should only be 4
  # items long.
  #
  def subject_array(subject, columns, lang = :english)
    sub_arr = []

    if subject.major?
      sub_arr.unshift({content: title_for(subject, lang).mb_chars.upcase.to_s, font: PdfReportCard::DEFAULT_BOLD_FONT})
    else
      sub_arr.unshift title_for(subject, lang)
    end

    (1..3).each do |p|
      if columns > 3
        # sub_arr << (subject.show_score? ? checkmark_replace(get_score(subject, p)) : "")
        sub_arr += positional_score(get_score(subject, p))
        sub_arr << (subject.show_effort? ? checkmark_replace(get_effort(subject, p)) : "")
      else
        sub_arr << checkmark_replace(get_effort(subject, p))
      end
    end

    sub_arr
  end

  def get_score(subject, period)
    fetch(['subjects', subject.id.to_s, 'periods', period.to_s, 'score'])
  end

  def get_effort(subject, period)
    fetch(['subjects', subject.id.to_s, 'periods', period.to_s, 'effort'])
  end

  def checkmark_replace(content)
    content == 'V' ? "✓" : content
  end

  def positional_score(score)
    (0..2).map{|i| i.to_s == score ? "✓" : ""}
  end

  def fetch(path = [])
    @report_card.fetch_data(path)
  end

  def main_subjects
    subject_scope.where(side_section: false)
  end

  def side_subjects
    subject_scope.where(side_section: true)
  end

  def subject_scope
    # Subject.where(id: @report_card.data['subjects'].keys).order(:position)
    @report_card.form.subjects.order(:position)
  end

  # def aeries_student
  #   @aeries_student ||= Aeries::Student.active.find_by(id: @report_card.student.aeries_id)
  # end

  def student
    @student ||= @report_card.student
  end

  def teacher_name
    @report_card.fetch_data(['teacher_name']) || student.homeroom.primary_teacher.name
  end

  def effort_cols
    [4,8,12]
  end

  def pos_score_cols
    (1..12).to_a - effort_cols
  end

  def format_effort_only_row(table, row_number)
    table.row(row_number).columns(0).align = :left
    table.row(row_number).columns(pos_score_cols).align = :left
    table.row(row_number).columns(effort_cols).align = :center

    table.row(row_number).columns(1..12).border_colors = [BLACK, WHITE]
    table.row(row_number).columns(effort_cols).border_colors = [BLACK, DGREY]
    table.row(row_number).columns([1,5,9]).border_left_color = DGREY
  end

  def title_for(subject, lang)
    if lang == :english
      subject.name
    else
      subject.spanish_name
    end
  end

  def lang_strings(key, lang = :english)
    strings = {}

    strings[:english] = {
      title_address: english_title,
      lang_arts: 'Language Arts',
      level: 'Instructional Level',
      ordinals: ['1st', '2nd', '3rd'],
      wsh: 'Work/Study Habits',
      cit: 'Citizenship',
      att: 'Attendance',
      policy: [
        {text: "Policy Statement", styles: [:bold], size: 10},
        {text: "\n\nThe Board of Education will authorize retention of students based upon their school attendance. A total of twenty-five (25) excused or unexcused absences during a school year will be cause for retention."}
      ]
    }

    strings[:spanish] = {
      title_address: spanish_title,
      lang_arts: 'Lengua Y Literatura',
      level: 'Nivel de Instrucción',
      ordinals: ['1er', '2do', '3er'],
      wsh: 'Habitos de Trabajo/Estudio',
      cit: 'Comportamiento',
      att: 'Asistencia',
      policy: [
        {text: "Informe de la Poliza", styles: [:bold], size: 10},
        {text: "\n\nEl Consejo Administrativo autorizará la retención de los estudiantes basado en la asistencia a la escuela. Un total de veinticinco (25) faltas con excusa o sin excusa durante el año escolar, será causa para reprobar el año."}
      ]
    }

    strings[lang][key]
  end
end
