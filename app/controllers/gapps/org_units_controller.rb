module Gapps
  class OrgUnitsController < ApplicationController

    def index
      @org_units = Gapps::OrgUnit.roots.includes(:children)
      authorize_general(:manage, :all, :gapps_org_units)
    end

    def new
      @org_unit = Gapps::OrgUnit.new
      authorize_general(:manage, :all, :gapps_org_units)
    end
  end
end
