# == Schema Information
#
# Table name: students
#
#  id                :integer          not null, primary key
#  first_name        :string
#  last_name         :string
#  middle_name       :string
#  sex               :string
#  birthdate         :date
#  site_id           :integer
#  grade_id          :integer
#  homeroom_id       :integer
#  home_lang_id      :integer
#  ethnicity_id      :integer
#  race_id           :integer
#  family_id         :integer
#  enrollment_status :integer          default(0), not null
#  flag              :integer          default(0), not null
#  legacy_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  import_details    :jsonb            not null
#  state             :integer          default(0), not null
#  ssid              :integer
#

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
