module Gapps
  module Api

    # == Google Directory API
    # OrgUnit
    #
    # {
    #   "kind": "admin#directory#orgUnit",
    #   "etag": etag,
    #   "name": string,
    #   "description": string,
    #   "orgUnitPath": string,
    #   "orgUnitId": string,
    #   "parentOrgUnitPath": string,
    #   "parentOrgUnitId": string,
    #   "blockInheritance": boolean
    # }

    class OrgUnit < Base
      CUSTOMER = "my_customer"

      def self.list
        service.list_org_units(CUSTOMER, type: "all")
      end

      def self.find(path, options = {})
        service.get_org_unit(CUSTOMER, path, options)
      end

      def self.import
        list.organization_units.each do |ou|
          create_or_update_from_api(ou)
        end
      end

      def self.create_or_update_from_api(api_obj)
        if org_unit = Gapps::OrgUnit.find_by(gapps_id: api_obj.org_unit_id)
          org_unit.update_from_api(api_obj)
        else
          Gapps::OrgUnit.create_from_api(api_obj)
        end
      end

      attr_reader :org_unit

      def initialize(org_unit)
        @org_unit = org_unit
      end

      def insert
        service.insert_org_unit(CUSTOMER, native_to_api(org_unit)) do |resp, err|
          if err
            Rails.logger.error err
            org_unit.update(state: 2)
            false
          else
            org_unit.update(state: 1, gapps_id: resp.id)
          end
        end
      end

      private

      def native_to_api(obj)
        Google::Apis::AdminDirectoryV1::OrgUnit.new({
          org_unit_id: obj.gapps_id,
          org_unit_path: obj.gapps_path,
          parent_org_unit_id: obj.gapps_parent_id,
          parent_org_unit_path: obj.gapps_parent_path,
          name: obj.name,
          description: obj.description
          })
      end

    end

  end
end
