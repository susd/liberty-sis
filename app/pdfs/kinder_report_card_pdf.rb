class KinderReportCardPdf < ReportCardPdf
  def initialize(report_card)
    @report_card = report_card
    @layout = PdfReportCard::Layouts::Kinder.new(data)
  end
  
  def render
    @layout.render_details(data['name'], data['school'], data['year'])
    @layout.render_title_address(lang_strings(:title_address, :english))
    @layout.render_header

    format_main_section(@layout, data['main_subjects'])
    format_side_section(@layout, data.slice('side_subjects', 'attendance'))
    
    @layout.render_footer(data['teacher'], data['principal'], data['next_grade'])
    
    @layout.start_new_page
    
    @layout.render_details(data['name'], data['school'], data['year'])
    @layout.render_comments(data['comments'])
    
    if data['comments'].values.flatten.count > 34
      @layout.start_new_page
    end
    
    # Spanish
    if @report_card.student.home_lang.name == 'Spanish'
      @layout.start_new_page
      @layout.render_details(data['name'], data['school'], data['year'])
      @layout.render_title_address(lang_strings(:title_address, :spanish))
      @layout.render_spanish_header
      format_main_section(@layout, data['spanish_main'], :spanish)
      format_side_section(@layout, {'side_subjects' => data['spanish_side'], 'attendance' => data['spanish_attendance']}, :spanish, 375, 445)
      @layout.render_spanish_footer(data['teacher'], data['principal'], data['next_grade'])
      @layout.start_new_page
      @layout.render_details(data['name'], data['school'], data['year'])
      @layout.render_comments(data['spanish_comments'], :spanish)
      
      if data['comments'].values.flatten.count > 34
        @layout.start_new_page
      end
    end
    
    @layout.render
  end
  
  private
  
  def format_main_section(layout, data, lang = :english)
    layout.main_section(data) do |sec|
      data.unshift [
        {content: lang_strings(:lang_arts, lang).upcase, font: PdfReportCard::DEFAULT_BOLD_FONT}, 
        {content: "", colspan: 4}, {content: "", colspan: 4}, {content: "", colspan: 4}
      ]
      
      sec.add_table(data, coords: [sec.rect.x, sec.rect.y - @layout.legend_rect.h]) do |tbl|
        tbl.width = sec.rect.w
        tbl.cells.border_width = 0.25
        tbl.cells.border_colors = [BLACK, DGREY]
        tbl.cells.valign = :center
        
        tbl.columns(0).width = sec.options[:label_width]
        tbl.columns(0).border_left_color = WHITE
        
        tbl.columns(1..12).width = (sec.rect.w - sec.options[:label_width]) / 12
        tbl.columns(1..12).align = :center
        
        # Lang Arts
        tbl.row(0).columns(1..12).background_color = GREY
        tbl.rows(0).column(0).border_left_color = BLACK
        
        #Reading
        tbl.row(1).align = :left
        tbl.row(1).columns(1..12).border_colors = [BLACK, WHITE]
        tbl.row(1).columns(effort_cols).border_colors = BLACK
        tbl.row(1).columns(effort_cols).align = :center
        tbl.row(1).columns([1,5,9]).border_left_color = DGREY
        
        # Written Lang
        # tbl.rows(5..6).column(0).border_left_color = DGREY
        tbl.row(5).align = :left
        tbl.row(5).columns(1..12).border_colors = [BLACK, WHITE]
        tbl.row(5).columns(effort_cols).border_colors = BLACK
        tbl.row(5).columns([1,5,9]).border_left_color = DGREY
        
        # Oral Language
        tbl.row(8).align = :left
        tbl.row(8).columns(1..12).border_colors = [BLACK, WHITE]
        tbl.row(8).columns(effort_cols).border_colors = BLACK
        tbl.row(8).columns([1,5,9]).border_left_color = DGREY
        
        # Maths
        tbl.row(11).align = :left
        tbl.row(11).column(0).border_left_color = BLACK
        tbl.row(11).columns(1..12).border_colors = [BLACK, WHITE]
        tbl.row(11).columns(effort_cols).border_colors = BLACK
        tbl.row(11).columns([1,5,9]).border_left_color = DGREY
        
        #Tech, PE
        tbl.rows(15..16).align = :left
        tbl.rows(15..16).columns(effort_cols).align = :center
        
        tbl.rows(15..22).columns(0).border_left_color = BLACK
        
        tbl.rows(19..22).columns(pos_score_cols).border_colors = [BLACK, GREY]
        tbl.rows(19..22).columns(pos_score_cols).background_color = GREY
        tbl.rows(19..22).columns(effort_cols).border_colors = BLACK
        tbl.rows(19..22).columns([1,5,9]).border_left_color = DGREY
      end
    end
  end
  
  def format_side_section(layout, data, lang = :english, att_offset = 355, pol_offset = 425)
    layout.side_section(data) do |sec|
      
      data['side_subjects'].insert(0, [lang_strings(:wsh, lang).mb_chars.upcase.to_s, lang_strings(:ordinals, lang)].flatten)
      data['side_subjects'].insert(9, [lang_strings(:cit, lang).mb_chars.upcase.to_s, lang_strings(:ordinals, lang)].flatten)
      
      sec.add_table(data['side_subjects']) do |tbl|
        tbl.width = sec.rect.w
        tbl.cells.border_width = 0.25
        tbl.cells.border_colors = [BLACK, 'A'*6]
        tbl.cells.valign = :center
        
        tbl.columns(0).width = sec.options[:label_width]
        tbl.columns(1..3).align = :center
        
        tbl.row(0).border_color = WHITE
        tbl.row(9).border_color = [BLACK, WHITE]
        # tbl.row([0,9]).height = 26
      end
      
      att_data = data['attendance']
      
      # att_data[0].first.titlecase
      # att_data[1].first.titlecase
      
      att_data.unshift([lang_strings(:att, lang).mb_chars.upcase.to_s, lang_strings(:ordinals, lang)].flatten)
      
      sec.add_table(att_data, coords: [sec.rect.x, sec.rect.y - 355]) do |tbl|
        tbl.width = sec.rect.w
        tbl.cells.border_width = 0.25
        tbl.cells.border_colors = [BLACK, 'A'*6]
        tbl.columns(0).width = sec.options[:label_width]
        tbl.columns(1..3).align = :center
        tbl.row(0).border_color = [WHITE, WHITE, BLACK, WHITE]
      end
      
      sec.add_policy(coords: [sec.rect.x, sec.rect.y - pol_offset], policy: lang_strings(:policy, lang))
      
    end
  end
  
  def english_title
    "Kindergarten Progress Report Card"
  end
  
  def spanish_title
    "Reporte de Progreso Kinder"
  end
end