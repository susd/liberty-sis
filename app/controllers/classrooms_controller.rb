class ClassroomsController < ApplicationController

  def index
    load_classrooms
    authorize_signed_in_user!
  end

  def show
    @classroom = Classroom.find(params[:id])
    @students = @classroom.students.order(:last_name)

    authorize_to(:view, @classroom)
  end

  private

  def load_classrooms(site_id = nil)
    if site_id
      @site = Site.find(site_id)
      @classrooms = @site.classrooms
    else
      @classrooms = Classroom.all
    end
  end

end
