module Gapps
  class OrgUnitsController < ApplicationController

    def index
      authorize_general(:manage, :all, :gapps_org_units)
    end
  end
end
