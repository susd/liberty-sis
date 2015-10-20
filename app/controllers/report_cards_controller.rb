class ReportCardsController < ApplicationController
  before_action :set_student
  after_action :authorize_teacher

  def index
    @report_cards = report_card_scope
    load_form_options
  end

  def show
    set_report_card
    set_attendance
  end

  private

  def set_student
    @student = Student.find(params[:student_id])
  end

  def set_report_card
    @report_card = report_card_scope.find(params[:id])
  end

  def set_attendance
    @attendance = @student.attendance_by_period
  end

  def report_card_scope
    @student.report_cards.order(created_at: :desc)
  end

  def load_form_options
    @forms = ReportCard::Form.all.map{|f| [f.name, f.id]}
  end

  def authorize_teacher
    authorize_to(:edit, @student)
  end
end
