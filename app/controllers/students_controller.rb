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

  private

  def load_student
    @student = Student.includes(:classrooms).find(params[:id])
  end
end
