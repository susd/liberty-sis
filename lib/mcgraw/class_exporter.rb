module Mcgraw

  class ClassExporter
    def self.header
      [
        "Last Name (required)",
        "First Name (required)",
        "Middle Initial (optional)",
        "Gender (M or F) (required)",
        "Grade Level (required)",
        "Disability Flag (optional)",
        "Free Lunch Eligibility (optional)",
        "Limited English (optional)",
        "Migrant Status (optional)",
        "Race (optional)",
        "Student ID (optional)",
        "Username (recommended)",
        "Password (recommended)",
        "Redemption Code (recommended)"
      ]
    end

    attr_reader :teacher

    def initialize(teacher)
      @teacher = teacher
    end

    def export_to(csv)
      rows.each{|r| csv << r}
    end

    def rows
      students.map{|s| StudentExporter.new(s).export }
    end

    def students
      teacher.students.order(:last_name)
    end

  end

end
