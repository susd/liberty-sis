class AdminController < ApplicationController
  before_action :authenticate_user!
  after_action :authorize_admin!
end
