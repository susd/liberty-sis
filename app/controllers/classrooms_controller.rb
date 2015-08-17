class ClassroomsController < ApplicationController

  def index
    @classrooms = Classroom.all
    authorize_signed_in_user!
  end

  def show
    @classroom = Classroom.find(params[:id])
    @students = @classroom.students.order(:last_name)

    authorize_to(:view, @classroom)
  end

end
