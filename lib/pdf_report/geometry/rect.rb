module PdfReport
  module Geometry

    class Rect
      attr_accessor :width, :height, :x, :y
      def initialize(width: 0, height: 0, x: 0, y: 0)
        @width = width
        @height = height
        @x = x
        @y = y
      end

      def w
        width
      end

      def h
        height
      end

      def bottom
        y - height
      end

      def right_top
        [x + width, y]
      end

      def draw(doc)
        doc.stroke_rectangle [x, y], width, height
      end

      def fill(doc)
        doc.fill_rectangle [x, y], width, height
      end

      def coords
        [x, y]
      end

      def to_bb
        [[x, y], {width: width, height: height}]
      end

      def padded_w(padding)
        width - (2 * padding)
      end

      def padded_h(padding)
        height - (2 * padding)
      end
    end

  end
end
