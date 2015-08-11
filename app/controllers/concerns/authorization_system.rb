module AuthorizationSystem
  NotAuthorized = Class.new(StandardError)
  AuthorizationNotChecked = Class.new(StandardError)

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

  def authorize_for_student_teacher!(student)
    authorize! do
      current_user.admin? || student.classroom.users.include?( current_user )
    end
  end

  def authorize_for_classroom!(classroom)
    authorize! do
      current_user.admin? || classroom.users.include?( current_user )
    end
  end

  def validate_authorization_checked
    return if @authorization_checked
    raise AuthorizationNotChecked
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
