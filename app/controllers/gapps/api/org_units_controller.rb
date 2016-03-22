module Gapps
  module Api

    class OrgUnitsController < ApplicationController
      before_action :authorize_gapps

      def update
        native = Gapps::OrgUnit.find(params[:id])

        if Gapps::SyncOrgUnitJob.perform_later(native)
          redirect_to :back, notice: "Org Unit scheduled to be synced"
        else
          redirect_to :back, notice: "Org Unit sync couldn't be scheduled"
        end
      end

      private

      def authorize_gapps
        authorize_general(:manage, :all, :gapps_org_units)
      end
    end

  end
end
