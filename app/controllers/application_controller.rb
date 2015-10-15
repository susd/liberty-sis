class ApplicationController < ActionController::Base
  include AuthorizationSystem

  before_action :authenticate_user!
  after_action :validate_authorization_checked

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_employee

  protected

  def current_employee
    @current_employee ||= current_user.employee
  end
end
