class ClassroomsController < ApplicationController

  def index
    load_sites
    scope_classrooms
    authorize!{ current_user.can_generally?(:view, :own, :classrooms) }
  end

  def show
    @classroom = Classroom.find(params[:id])
    @students = @classroom.students.order(:last_name)
    check_for_pdf

    authorize_to(:view, @classroom)
  end

  def show_cached
    set_classroom
    respond_to do |format|
      format.pdf do
        options = {
          filename: @classroom.combined_pdf_name,
          type: "application/pdf",
          disposition: "inline"
        }
        send_file(@classroom.combined_pdf_path, options)
      end
    end
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

    ReportCard::ClassroomCombiner.new(@classroom).pdf_paths.each do |f|
      File.delete(f) if File.exists?(f)
    end

    File.delete(@classroom.combined_pdf_path)
    redirect_to @classroom
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

  def scope_classrooms
    if params[:site_id]
      @site = Site.find(params[:site_id])
      criteria = ViewableClassroomsQuery.new(current_user, @site.classrooms).user_classrooms
    else
      criteria = ViewableClassroomsQuery.new(current_user).user_classrooms
    end
    @classrooms = criteria.page(params[:page]).per(40)
  end

  def set_classroom
    @classroom = Classroom.find params[:id]
  end

  def load_sites
    if current_employee.multisite?
      @sites = current_employee.sites.with_classrooms.order(:abbr)
    end
  end

  def check_for_pdf
    if File.exists? @classroom.combined_pdf_path
      @cached_pdf_path = @classroom.combined_pdf_path.to_s
    end
  end

end
