class StudentsController < ApplicationController
  def index
  end

  def show
    load_student
    authorize_for_student_teacher!(@student)
  end

  private

  def load_student
    @student = Student.includes(:classrooms).find(params[:id])
  end
end
