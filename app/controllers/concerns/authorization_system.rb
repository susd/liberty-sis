module AuthorizationSystem
  extend ActiveSupport::Concern

  NotAuthorized = Class.new(StandardError)
  AuthorizationNotChecked = Class.new(StandardError)

  included do
    rescue_from NotAuthorized, with: :deny_access
  end

  protected

  def authorize!
    @authorization_checked = true
    raise NotAuthorized unless yield
  end

  def authorize_signed_in_user!
    authorize! { user_signed_in? }
  end

  def authorize_admin!
    authorize! { current_user.admin? }
  end

  def authorize_to(action, target)
    authorize! do
      current_user.can?(action, target)
    end
  end

  def validate_authorization_checked
    return if @authorization_checked
    raise AuthorizationNotChecked
  end

  def deny_access
    redirect_to forbidden_path, status: 403
  end
end

# class ApplicationController < ActionController::Base
#   include AuthorizationSystem
#   after_action :validate_authorization_checked
# end

# class MessagesController < ApplicationController
#   # ...
#   def show
#     @message = Message.find(params[:id])
#     authorize! { current_user.can_view? @message }
#   end
# end
