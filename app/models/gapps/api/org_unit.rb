module Gapps
  module Api

    class OrgUnit < Base
      CUSTOMER = "my_customer"

      def self.list
        service.list_org_units(CUSTOMER)
      end

      def self.find(path, options = {})
        service.get_org_unit(CUSTOMER, path, options)
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
