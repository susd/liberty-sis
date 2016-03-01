module ReportCards
  class FormOptionsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    before_action :set_form
    helper_method :submit_path_for

    def index
      @form_options = @form.form_options
    end

    def show
      @form_option = @form.form_options.find(params[:id])
    end

    def new
      @form_option = @form.form_options.new
    end

    def edit
      @form_option = @form.form_options.find(params[:id])
    end

    def create
      @form_option = @form.form_options.new(form_option_params)

      if @form_option.save
        redirect_to report_cards_form_options_path, notice: 'Option saved'
      else
        render :new
      end
    end

    def update
      @form_option = @form.form_options.find(params[:id])

      if @form_option.update(form_option_params)
        redirect_to report_cards_form_options_path, notice: 'Option updated'
      else
        render :edit
      end
    end

    def destroy
      @form_option = @form.form_options.find(params[:id])
      @form_option.destroy
      redirect_to report_cards_form_options_path, alert: 'Option deleted'
    end

    private

    def set_form
      @form = ReportCard::Form.find(params[:form_id])
    end

    def form_option_params
      params.require(:report_card_form_option).permit!
    end

    def submit_path_for(form, option)
      if option.new_record?
        report_cards_form_options_path(form)
      else
        report_cards_form_option_path(form, option)
      end
    end
  end
end
