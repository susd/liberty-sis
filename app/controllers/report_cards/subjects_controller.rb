class ReportCards::SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_form
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  helper_method :adjusted_subject_form_path

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = subject_scope
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    @subject = subject_scope.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = subject_scope.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to report_cards_form_subjects_path(@form), notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: report_cards_form_subjects_path(@form) }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to report_cards_form_subjects_path(@form), notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: report_cards_form_subjects_path(@form) }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to form_subjects_url(@form), notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_form
    @form = ReportCard::Form.find(params[:form_id])
  end

  def set_subject
    @subject = subject_scope.find(params[:id])
  end

  def subject_scope
    @form.subjects.order(:position)
  end

  def subject_params
    permitted = [
      :name, :slug, :form_id, :major,
      :positional_score, :show_score,
      :show_effort, :show_level,
      :side_section, :position, :spanish_name
    ]
    params.require(:report_card_subject).permit(*permitted)
  end

  def adjusted_subject_form_path
    if @subject.new_record?
      report_cards_form_subjects_path(@form)
    else
      report_cards_form_subject_path(@form, @subject)
    end
  end
end
