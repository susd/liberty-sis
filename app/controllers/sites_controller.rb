# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :text
#  principal  :text
#  abbr       :text
#  code       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
