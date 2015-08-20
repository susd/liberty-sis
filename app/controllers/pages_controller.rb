class PagesController < ApplicationController
  def forbidden
    render status: :forbidden
    authorize!{ true }
  end
end
