class ReportCardsController < ApplicationController
  before_action :set_student
  after_action :authorize_teacher

  def index
    @report_cards = report_card_scope
    load_form_options
  end

  def show
    set_report_card
    # set_attendance
    check_for_pdf

    respond_to do |format|
      format.html
      format.pdf do
        pdf = "#{@report_card.form.renderer.capitalize}ReportCardPdf".constantize.new(@report_card)
        options = {
          filename: @report_card.cache_name,
          type: "application/pdf",
          disposition: "inline"
        }
        send_data pdf.render, options
      end
    end
  end

  def show_cached
    set_report_card
    respond_to do |format|
      format.pdf do
        options = {
          filename: @report_card.cache_name,
          type: "application/pdf",
          disposition: "inline"
        }
        send_file(@report_card.cache_path, options)
      end
    end
  end

  def generate
    respond_to do |format|
      if BuildStudentPdfJob.perform_later(@student)
        format.html do
          redirect_to student_report_card_path(@student, @report_card), notice: "Started building PDF, check back in a sec."
        end
        format.js
      else
        format.html { redirect_to student_report_card_path(@student, @report_card), alert: "PDF couldn't be generated." }
        format.js { render js: "alert('Sorry, something went wrong')" }
      end
    end
  end

  def clear
    Dir["#{@report_card.cache_dir}/*"].each{|f| File.delete(f)}
    redirect_to student_report_card_path(@student, @report_card)
  end

  def check
    set_report_card
    check_for_pdf
    respond_to do |format|
      format.html { redirect_to student_report_card_path(@student, @report_card) }
      format.js
    end
  end

  def new
    @report_card = report_card_scope.new
  end

  def edit
    set_report_card
    set_subjects
    set_comment_groups
  end

  def create
    @report_card = report_card_scope.new(report_card_params)
    if @report_card.save
      redirect_to edit_student_report_card_path(@student, @report_card)
    else
      @report_cards = report_card_scope
      load_form_options
      render :new
    end
  end

  def update
    set_report_card
    if @report_card.update(report_card_params)
      if params[:continue]
        dest = edit_student_report_card_path(@student, @report_card)
      else
        dest = student_report_card_path(@student, @report_card)
      end
      redirect_to dest, notice: 'Report card saved.'
    else
      render :edit
    end
  end

  def destroy
    @report_card.destroy
    respond_to do |format|
      format.html { redirect_to student_report_cards_path(@student), notice: 'Report card was successfully destroyed.' }
      format.json { head :no_content }
    end
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

  def report_card_params
    params.require(:report_card).permit!.merge(student_id: @student.id)
  end

  def report_card_scope
    @student.report_cards.order(created_at: :desc)
  end

  def load_form_options
    @forms = ReportCard::Form.all.map{|f| [f.name, f.id]}
  end

  def check_for_pdf
    if File.exists? @report_card.cache_path
      @cached_pdf_path = @report_card.cache_path
    end
  end

  def authorize_teacher
    authorize_to(:edit, @student)
  end

end
