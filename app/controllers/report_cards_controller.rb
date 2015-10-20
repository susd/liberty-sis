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

    respond_to do |format|
      format.html
      format.pdf do
        pdf = "#{@report_card.form.renderer.capitalize}ReportCardPdf".constantize.new(@report_card)
        options = {
          filename: report_card_filename,
          type: "application/pdf",
          disposition: "inline"
        }
        send_data pdf.render, options
      end
    end
  end

  def edit
    set_report_card
    set_subjects
    set_comment_groups
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

  def set_subjects
    @subjects = @report_card.form.subjects.order(:position)
  end

  def set_comment_groups
    @comment_groups = @report_card.comment_groups.includes(:comments)
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

  def report_card_filename
    "#{@student.name.parameterize}_report_card_#{@report_card.updated_at.strftime('%Y-%m-%d')}.pdf"
  end
end
