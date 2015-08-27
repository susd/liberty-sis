module Pearson
  module SuccessNet

    # SuccessNet Roster is uploaded through EasyBridge so it's csv

    class RosterExporter

      def self.header
        ["Student Username",	"Teacher Username",	"Class Name"]
      end

      attr_reader :teacher, :persona

      def initialize(teacher)
        @teacher = teacher
        @persona = teacher.personas.find_by(handler: 'successnet')
      end

      def export_to(csv)
        rows.each{|r| csv << r}
      end

      def rows
        students.map{|s| [StudentExporter.new(s).persona.username, persona.username, persona.username] }
      end

      def students
        teacher.students
      end

    end

  end
end
