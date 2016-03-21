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
            # update info
            # set native parent
            org_unit.update(
              state: 1,
              gapps_id: resp.org_unit_id,
              gapps_path: resp.org_unit_path,
              gapps_parent_id: resp.parent_org_unit_id,
              gapps_parent_path: resp.parent_org_unit_path
              )
          end
        end
      end

      private

      def native_to_api(native)
        Google::Apis::AdminDirectoryV1::OrgUnit.new({
          org_unit_id: native.gapps_id,
          org_unit_path: native.gapps_path,
          name: native.name,
          description: native.description
        }.merge(native.api_attrs_from_parent))
      end

    end

  end
end
