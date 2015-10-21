class ClassroomsController < ApplicationController

  def index
    load_classrooms
    authorize{ current_user.can_generally?(:view, :all, :classrooms) }
  end

  def show
    @classroom = Classroom.find(params[:id])
    @students = @classroom.students.order(:last_name)

    authorize_to(:view, @classroom)
  end

  def generate
    set_classroom
    authorize_to(:manage, @classroom)

    respond_to do |format|
      if BuildClassroomPdfJob.perform_later(@classroom)
        format.html{ redirect_to @classroom, notice: "Started building PDF, check back in a sec." }
        format.js
      else
        format.html{ redirect_to @classroom, alert: "PDF couldn't be generated." }
        format.js { render js: "alert('Sorry, something went wrong')" }
      end
    end
  end

  def clear
    set_classroom
    authorize_to(:manage, @classroom)

    ClassroomCombiner.new(@classroom).pdf_paths.each do |f|
      File.delete(f) if File.exists?(f)
    end

    File.delete(@classroom.combined_pdf_path)
  end

  def check
    set_classroom
    authorize_to(:manage, @classroom)
    check_for_pdf
    respond_to do |format|
      format.html { redirect_to @classroom }
      format.js
    end
  end

  private

  def load_classrooms
    if params[:site_id]
      @site = Site.find(params[:site_id])
      @classrooms = @site.classrooms
    else
      @classrooms = Classroom.all
    end
  end

  def set_classroom
    @classroom = Classroom.find params[:id]
  end

end
