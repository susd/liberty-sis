module PdfReportCard
  module Components
    
    class ContentRow < BoxRow
      
      def initialize(document, full_rect, options = {})
        @options = defaults.merge(options)
        
        if @options[:content].any?
          @content = content
        else
          @content = [nil] * count
        end
        
        super(full_rect, document, count: count, start_x: start_x, start_y: start_y, border_mask: border_mask)
      end
      
      def label_rect
        @l_rect ||= Geometry::Rect.new(width: label_w, height: @rect.h, x: @rect.x, y: @rect.y)
      end
      
      def content_rect
        width = (@rect.w - label_w) / count
        @c_rect ||= Geometry::Rect.new(width: width, height: @rect.h, x: (start_x + label_rect.w), y: @rect.y)
      end
      
      def draw_borders
        draw_label_border
        
        box_loop do |i|
          x_pos = (label_rect.x + label_rect.w) + (i * content_rect.w)
          args = [[x_pos, content_rect.y], content_rect.w, content_rect.h]
          
          case
          when border_mask[i] == 1 && fill_mask[i] == 1
            @doc.fill_and_stroke_rectangle *args
          when border_mask[i] == 1
            @doc.stroke_rectangle *args
          when fill_mask[i] == 1
            @doc.fill_rectangle *args
          end
        end
        
        draw_main_border
      end
      
      def write_title
        pad = @doc.font_size
        txt = [{text: label, styles: label_styles}]
        txt_x = @rect.x + pad
        txt_w = label_w - (2 * pad)
        txt_rect = Geometry::Rect.new(width: txt_w, height: @rect.h, x: txt_x, y: @rect.y)
        RowTextBox.new(@doc, txt_rect, txt, 0, align_options).render
      end
      
      def write_content
        count.times do |i|
          unless @content[i].nil?
            txt = [{text: @content[i].to_s}]
            RowTextBox.new(@doc, content_rect, txt, i, align_options.merge(align: :center)).render
          end
        end
      end
      
      def render
        draw_borders
        write_title
        write_content
      end
      
      private
      
      def box_loop
        count.times do |i|
          @doc.fill_color(PdfReportCard::DEFAULT_FILL_COLOR)
          yield(i) if block_given?
          @doc.fill_color(PdfReportCard::DEFAULT_FONT_COLOR)
        end
      end
      
      def draw_main_border
        doc_weight = @doc.line_width
        if @options.has_key?(:border_weight)
          @doc.line_width = PdfReportCard::BORDER_WEIGHTS[@options[:border_weight]]
        end
        @doc.stroke_rectangle [@rect.x, @rect.y], @rect.w, @rect.h
        @doc.line_width = doc_weight
      end
      
      def draw_label_border
        @doc.stroke_rectangle [start_x, @rect.y], label_w, @rect.h
      end
      
      def label
        @options[:label] || @options[:title]
      end
      
      def defaults
        {
          title: nil, 
          label_w: 100, 
          count: 3, 
          start_x: 0, 
          start_y: 0, 
          border_mask: [0],
          fill_mask: [0],
          content: [], 
          label_styles: [], 
          label_align: :left,
          label_valign: :center
        }
      end
      
      def align_options
        {
          align:  @options[:label_align],
          valign: @options[:label_valign]
        }
      end
      
      def method_missing(name, *args, &block)
        if @options.has_key? name
          @options[name]
        else
          super
        end
      end
      
    end
    
  end
end