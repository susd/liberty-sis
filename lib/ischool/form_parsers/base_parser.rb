module Ischool
  module FormParsers

    class BaseParser
      def initialize(raw_data)
        @data = raw_data
        @subjects = subjects_scope.to_a
        @result = Hash.new{|h,k| h[k] = Hash.new(&h.default_proc) }
      end

      def card_level
        'base'
      end

      def parse!
        parse_subjects
        parse_comments
        parse_attendance

        @result
      end

      def parse_subjects
        @data.each do |k, v|
          if desired_fields.include? k
            map_key = value_map.detect{|mk,mv| mv.include? k || mv == k }.first
            sub_name, period, sub_key = map_key.split('.')

            if subject = subject_lookup( sub_name )
              path = [subject.id, period, sub_key]
              if ['level', 'effort'].include? sub_key
                parse_single_value(path, v)
              else
                parse_positional_value(path, map_key)
              end
            end

          end
        end

        @result
      end

      def parse_attendance
        @result['attendance'] ||= {}
        attendance_map.each do |source_key, target_key|
          type, period = target_key.split('.')
          @result['attendance'][period.to_i][type] = @data[source_key].to_i
        end
        @result
      end

      def parse_comments
        period = '1'
        @result['comments'][period]['comment_ids'] = []

        @data['comments'].each do |comment|
          case comment.strip
          when '1st Grading Period'
            period = '1'
            @result['comments'][period]['comment_ids'] = []
          when '2nd Grading Period'
            period = '2'
            @result['comments'][period]['comment_ids'] = []
          when '3rd Grading Period'
            period = '3'
            @result['comments'][period]['comment_ids'] = []
          else
            if found = comments_scope.find_by(english: comment.sub(/\s•\s/,''))
              @result['comments'][period]['comment_ids'] << found.id
            end
          end
        end

        @result
      end

      def comments_scope
        form_scope.comments
      end

      def subjects_scope
        form_scope.subjects
      end

      def subjects_array
        @subjects ||= subjects_scope.to_a
      end

      def form_scope
        ReportCard::Form.find_by(renderer: card_level)
      end

      private

      def unescape(str)
        CGI.unescape( str ) unless str.nil?
      end

      def parse_single_value(target_path, value)
        # @result['subjects'][subject_id.to_s]['periods'][period][sub_key] = @data[]
        id, period, key = target_path
        @result['subjects'][id.to_s]['periods'][period][key] = unescape( value )
      end

      def parse_positional_value(target_path, map_key)
        id, period, key = target_path
        @result['subjects'][id.to_s]['periods'][period][key] = value_map[map_key].index(@data.slice(*value_map[map_key]).keys.first)
      end

      def subject_lookup(name)
        subjects_array.detect{|s| s.slug == "#{card_level}-#{name}".downcase}
      end

    end #/class

  end
end
