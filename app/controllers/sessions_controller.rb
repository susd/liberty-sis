class SessionsController < Devise::SessionsController
  skip_after_action :validate_authorization_checked
end
