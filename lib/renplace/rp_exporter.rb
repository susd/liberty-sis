class RpExporter
  attr_reader :student

  def initialize(student)
    @student = student
    @persona = student.personas.find_by(handler: 'renplace')
  end

  def export
    attrs.values
  end

  def attrs
    {
      :sid        => @student.import_details['import_id'],
      :sfirst     => @student.first_name,
      :slast      => @student.last_name,
      :sbirthday  => @student.birthdate.strftime('%m/%d/%Y'),
      :sgrade     => grade,
      :susername  => @persona.username,
      :spassword  => @persona.password
    }
  end

  def grade
    gr = @student.grade.simple
    gr == 0 ? 'K' : gr
  end
end
