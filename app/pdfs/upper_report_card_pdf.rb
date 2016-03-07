class UpperReportCardPdf < ReportCardPdf

  def initialize(report_card)
    @report_card = report_card
    @layout = PdfReportCard::Layouts::Upper.new(data)
  end

  def render
    # 1st Page
    @layout.render_details(data['name'], data['school'], data['year'])
    @layout.render_title_address("Upper Grade Progress Report Card\nGrades 4-6")
    @layout.render_header

    format_main_section(@layout, data['main_subjects'])

    format_side_section(@layout, data.slice('side_subjects', 'attendance'))

    @layout.render_footer(data['teacher'], data['principal'], data['next_grade'], data['services'])

    @layout.start_new_page

    # 2nd Page
    @layout.render_details(data['name'], data['school'], data['year'])
    @layout.render_comments(data['comments'])

    if data['comments'].values.flatten.count > COMMENT_BREAK
      @layout.start_new_page
    end

    # Spanish
    if @report_card.student.home_lang.name == 'Spanish'
      @layout.start_new_page
      @layout.render_details(data['name'], data['school'], data['year'])
      @layout.render_title_address(lang_strings(:title_address, :spanish))
      @layout.render_spanish_header
      format_main_section(@layout, data['spanish_main'], :spanish)
      format_side_section(@layout, {'side_subjects' => data['spanish_side'], 'attendance' => data['spanish_attendance']}, :spanish, 320, 385)
      @layout.render_spanish_footer(data['teacher'], data['principal'], data['next_grade'], data['services'])
      @layout.start_new_page
      @layout.render_details(data['name'], data['school'], data['year'])
      @layout.render_comments(data['spanish_comments'], :spanish)

      if data['comments'].values.flatten.count > COMMENT_BREAK
        @layout.start_new_page
      end
    end

    @layout.render
  end

  private

  def tabulate_subjects(subjects, columns = 6, lang = :english)
    result = []

    subjects.each do |subject|
      result << subject_array(subject, columns, lang)

      if subject.show_level?
        level_arr = [{content: lang_strings(:level, lang), align: :right, font: PdfReportCard::DEFAULT_ITALIC_FONT}]

        unless fetch(['subjects', subject.id.to_s, 'periods']).nil?
          level_arr += fetch(['subjects', subject.id.to_s, 'periods']).map do |p, pdata|
            {content: pdata['level'], colspan: 2}
          end
        end

        result << level_arr
      end

    end
    result
  end

  # Build an array of subject marks
  # If this is a long row (6 columns) then
  # fill all six columns, accounting for
  # subjects that don't show scores.
  # Otherwise the array should only be 4
  # items long.

  def subject_array(subject, columns, lang = :english)
    sub_arr = []

    if subject.major?
      sub_arr.unshift({content: title_for(subject, lang).mb_chars.upcase.to_s, font: PdfReportCard::DEFAULT_BOLD_FONT})
    else
      sub_arr.unshift title_for(subject, lang)
    end

    (1..3).each do |p|
      if columns > 3
        sub_arr << (subject.show_score? ? checkmark_replace(get_score(subject, p)) : "")
        sub_arr << (subject.show_effort? ? checkmark_replace(get_effort(subject, p)) : "")
      else
        sub_arr << checkmark_replace(get_effort(subject, p))
      end
    end

    sub_arr
  end

  def english_title
    "Upper Grade Progress Report Card\nGrades 4-6"
  end

  def spanish_title
    "Reporte de Progreso\nGrado 4-6"
  end

  def build_card(layout, lang = :english)
    layout.render_details(data['name'], data['school'], data['year'])
    layout.render_title_address(lang_strings(:title_address, lang))
    # @layout.build_header do |h|
    #   h.legend1 lang_strings(:legend1, lang)
    #   h.legend2 lang_strings(:legend2, lang)
    #   h.heading_items lang_strings(:heading_items, lang)
    # end
    if lang == :english
      layout.render_header
    else
      layout.render_spanish_header
    end

    format_main_section(layout, data, lang)
    format_side_section(layout, data, lang)
  end

  def format_main_section(layout, data, lang = :english)
    layout.main_section(data) do |sec|

      data.unshift [
        {content: lang_strings(:lang_arts, lang).mb_chars.upcase.to_s, font: PdfReportCard::DEFAULT_BOLD_FONT},
        {content: "", colspan: 2}, {content: "", colspan: 2}, {content: "", colspan: 2}
      ]

      sec.add_table(data, coords: [sec.rect.x, sec.rect.y - @layout.legend_rect.h]) do |tbl|
        tbl.width = sec.rect.w
        tbl.cells.border_width = 0.25
        tbl.cells.border_colors = [BLACK, 'A'*6]
        tbl.columns(0).width = sec.options[:label_width]
        tbl.columns(1..6).width = (sec.rect.w - sec.options[:label_width]) / 6
        tbl.columns(0).border_left_color = WHITE
        tbl.columns(1..6).align = :center

        # Lang Arts
        tbl.row(0).columns(1..6).background_color = GREY
        tbl.rows(0..2).column(0).border_left_color = BLACK

        # Written Lang
        tbl.rows(5..6).column(0).border_left_color = BLACK
        # Oral Language
        tbl.row(11).column(0).border_left_color = BLACK
        # Maths
        tbl.rows(14..15).column(0).border_left_color = BLACK

        tbl.rows(22..24).columns([1,3,5]).background_color = GREY
      end
    end
  end

  def format_side_section(layout, data, lang = :english, att_offset = 288, pol_offset = 360)
    layout.side_section(data) do |sec|
      data['side_subjects'].insert(0, [lang_strings(:wsh, lang).mb_chars.upcase.to_s, lang_strings(:ordinals, lang)].flatten)
      data['side_subjects'].insert(9, [lang_strings(:cit, lang).mb_chars.upcase.to_s, lang_strings(:ordinals, lang)].flatten)

      sec.add_table(data['side_subjects']) do |tbl|
        tbl.width = sec.rect.w
        tbl.cells.border_width = 0.25
        tbl.cells.border_colors = [BLACK, 'A'*6]
        tbl.columns(0).width = sec.options[:label_width]
        tbl.columns(1..3).align = :center

        tbl.row(0).border_color = WHITE
        tbl.row(9).border_color = [BLACK, WHITE]
        # tbl.row([0,9]).height = 26
        tbl.row([0,9]).valign = :center
      end

      att_data = data['attendance'].to_a.map(&:flatten).map{|arr| arr.map(&:to_s)}

      att_data[0].first.titlecase
      att_data[1].first.titlecase

      att_data.unshift([lang_strings(:att, lang).mb_chars.upcase.to_s, lang_strings(:ordinals, lang)].flatten)

      sec.add_table(att_data, coords: [sec.rect.x, sec.rect.y - att_offset]) do |tbl|
        tbl.width = sec.rect.w
        tbl.cells.border_width = 0.25
        tbl.cells.border_colors = [BLACK, 'A'*6]
        tbl.columns(0).width = sec.options[:label_width]
        tbl.columns(1..3).align = :center
        tbl.row(0).border_color = [BLACK, WHITE]
      end

      sec.add_policy(coords: [sec.rect.x, sec.rect.y - pol_offset], policy: lang_strings(:policy, lang))
    end
  end

end
