class SitesController < ApplicationController
  def index
    @sites = ViewableSitesQuery.new(current_user).sites
    authorize_general(:view, :own, :sites)
  end

  def show
    @site = Site.find(params[:id])
    authorize!{ current_user.can?(:view, @site) }
  end
end
