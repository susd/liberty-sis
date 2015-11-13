class StudentsController < ApplicationController
  def show
    load_student
    authorize_to(:view, @student)
  end

  def search
    authorize_general(:view, :all, :students)

    query = params[:term] || params[:query]
    @students = Student.includes(:homeroom, :site).admin_search(query).limit(20)

    respond_to do |format|
      format.js
    end
  end

  def edit
    load_student
    load_languages
    authorize_to(:edit, @student)
  end

  def update
    load_student
    authorize_to(:edit, @student)
    if @student.update(student_params)
      redirect_to @student, notice: 'Student updated'
    else
      load_languages
      render :edit
    end
  end

  private

  def load_student
    @student = Student.includes(:classrooms).find(params[:id])
  end

  def load_languages
    @langs = Language.where(name: %w{English Spanish}).pluck(:name, :id)
  end

  def student_params
    params.require(:student).permit(:home_lang_id)
  end
end
