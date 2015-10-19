class ReportCards::FormsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  
  def index
    @forms = forms_scope.order(:name)
  end
  
  def show
    @form = forms_scope.find(params[:id])
  end
  
  def create
    @form = forms_scope.new(form_params)
    if @form.save
      redirect_to report_cards_forms_path, notice: 'Form created'
    else
      render :index
    end
  end
  
  private
  
  def forms_scope
    Form
  end
  
  def form_params
    params.require(:form).permit(:name, :renderer)
  end
end