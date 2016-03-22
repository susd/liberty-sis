module Gapps
  class OrgUnitsController < ApplicationController
    before_action :authorize_gapps

    def index
      @org_units = Gapps::OrgUnit.roots.includes(:children).order(:name)
    end

    def show
      @org_unit = Gapps::OrgUnit.includes(:parent).find(params[:id])
    end

    def new
      @org_unit = Gapps::OrgUnit.new
    end

    def edit
      @org_unit = Gapps::OrgUnit.find(params[:id])
    end

    def create
      @org_unit = Gapps::OrgUnit.new(org_unit_params)
      if @org_unit.save
        redirect_to gapps_org_units_path, notice: "Org Unit saved"
      else
        render :new
      end
    end

    def update
      @org_unit = Gapps::OrgUnit.find(params[:id])
      if @org_unit.update(org_unit_params)
        redirect_to gapps_org_units_path, notice: "Org Unit updated"
      else
        render :edit
      end
    end

    private

    def org_unit_params
      params.require(:gapps_org_unit).permit!
    end

    def authorize_gapps
      authorize_general(:manage, :all, :gapps_org_units)
    end
  end
end
