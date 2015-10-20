class SitesController < ApplicationController
  def index
    @sites = Site.order(:code)
    authorize_general(:view, :all, :sites)
  end

  def show
    @site = Site.find(params[:id])
    authorize!{ current_user.can?(:view, @site) }
  end
end
