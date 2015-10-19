class TkReportCardPdf < ReportCardPdf
  def initialize(report_card)
    @report_card = report_card
    @layout = PdfReportCard::Layouts::Tk.new(data)
  end
  
  def render
    # @layout.fill_page_areas
    @layout.render_details
    @layout.render_title_address("Transitional Kindergarten Progress Report Card")
    @layout.render_header

    @layout.main_section do |sec|
      
      sec.add_table(data['main_subjects'], coords: [sec.rect.x, sec.rect.y - @layout.legend_rect.h]) do |tbl|
        tbl.width = sec.rect.w
        tbl.cells.border_width = 0.25
        tbl.cells.border_colors = [BLACK, DGREY]
        tbl.cells.valign = :center
        
        tbl.columns(0).width = sec.options[:label_width]
        tbl.columns(0).border_left_color = WHITE
        
        tbl.columns(1..12).width = (sec.rect.w - sec.options[:label_width]) / 12
        tbl.columns(1..12).align = :center
        
        # Lang Arts
        format_effort_only_row(tbl, 0)
        
        # Maths
        format_effort_only_row(tbl, 6)
        
        # Emo Dev
        format_effort_only_row(tbl, 10)
        
        # Phys Dev
        format_effort_only_row(tbl, 15)
        
        # Social - Art
        format_effort_only_row(tbl, (19..22))
        
        tbl.rows(19..22).columns(pos_score_cols).border_colors = [BLACK, GREY]
        tbl.rows(19..22).columns(pos_score_cols).background_color = GREY
      end
    end
    
    @layout.side_section do |sec|
      
      data['side_subjects'].insert(0, ['Work/Study Habits'.upcase, '1st', '2nd', '3rd'])
      data['side_subjects'].insert(8, ['Citizenship'.upcase, '1st', '2nd', '3rd'])
      
      sec.add_table(data['side_subjects']) do |tbl|
        tbl.width = sec.rect.w
        tbl.cells.border_width = 0.25
        tbl.cells.border_colors = [BLACK, 'A'*6]
        tbl.cells.valign = :center
        
        tbl.columns(0).width = sec.options[:label_width]
        tbl.columns(1..3).align = :center
        
        tbl.row(0).border_color = WHITE
        tbl.row(8).border_color = [BLACK, WHITE]
      end
      
      att_data = data['attendance']
      
      att_data.unshift(['Attendance'.upcase, '1st', '2nd', '3rd'])
      
      sec.add_table(att_data, coords: [sec.rect.x, sec.rect.y - 355]) do |tbl|
        tbl.width = sec.rect.w
        tbl.cells.border_width = 0.25
        tbl.cells.border_colors = [BLACK, 'A'*6]
        tbl.columns(0).width = sec.options[:label_width]
        tbl.columns(1..3).align = :center
        tbl.row(0).border_color = [WHITE, WHITE, BLACK, WHITE]
      end
      
      sec.add_policy
      
    end
    
    @layout.render_footer(data['teacher'], data['principal'], data['next_grade'])
    
    if data['comments'].any?
      @layout.start_new_page
    
      @layout.render_details
      @layout.render_comments(data['comments'])
    end
    
    @layout.render
  end
  
  def english_title
    "Transitional Kindergarten Progress Report Card"
  end
  
  def spanish_title
    "Reporte de Progreso"
  end
  
end