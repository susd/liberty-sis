class PagesController < ApplicationController
  def forbidden
    authorize!{ true }
  end
end
