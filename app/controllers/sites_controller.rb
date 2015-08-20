class SitesController < ApplicationController
  def index
    @sites = Site.all
    authorize_general(:view, :all, :sites)
  end
end
