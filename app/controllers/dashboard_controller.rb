class DashboardController < ApplicationController
  def index
    authorize_signed_in_user!
  end
end
