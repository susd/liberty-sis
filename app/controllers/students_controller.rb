class StudentsController < ApplicationController
  def show
    load_student
    authorize_to(:view, @student)
  end

  private

  def load_student
    @student = Student.includes(:classrooms).find(params[:id])
  end
end
