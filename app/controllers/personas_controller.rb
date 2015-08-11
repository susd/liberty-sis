class PersonasController < ApplicationController
  before_action :load_student

  def index
    @personas = @student.personas
    authorize_for_student_teacher!(@student)
  end

  private

  def load_student
    @student = Student.find(params[:student_id])
  end
end
