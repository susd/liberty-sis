module Gapps
  module Api

    class User < Base
      validate :record_has_email
      validate :record_has_org_unit

      def self.find(email)
        service.get_user(email)
      end

      attr_reader :record, :persona

      def initialize(persona)
        @persona = persona
        @record = persona.personable
      end

      def upsert
        if persona.active?
          update
        else
          insert
        end
      end

      def insert
        if valid?
          SyncEvent.wrap(label: "gapps:user", action: 1, syncable: persona) do
            service_insert
          end
        else
          false
        end
      end

      def update
        if valid?
          SyncEvent.wrap(label: "gapps:user", action: 1, syncable: persona) do
            service_update
          end
        else
          false
        end
      end

      private

      def service_insert
        service.insert_user(native_to_api) do |resp, err|
          if err
            Rails.logger.error err
            false
          else
            persona.update(state: 1, service_id: resp.id, synced_at: Time.now.utc)
          end
        end
      end

      def service_update
        service.patch_user(persona.service_id, native_to_api) do |resp, err|
          if err
            Rails.logger.error err
            false
          else
            persona.update(state: 1, synced_at: Time.now.utc)
          end
        end
      end

      def native_to_api
        GAdmin::User.new({
          primary_email: persona.username,
          password: persona.password,
          name: {
            family_name: record.last_name,
            given_name: record.first_name,
            full_name: record.name
          },
          org_unit_path: org_path,
          external_ids: record.gapps_external_ids,
          include_in_global_address_list: include_in_global?
        })
      end

      def org_path
        if ou = record.org_unit
          ou.gapps_path
        else
          Gapps::OrgUnit.fallback_path
        end
      end

      def include_in_global?
        record.is_a? Employee
      end

      def record_has_email
        if record.is_a?(Employee) && record.email.blank?
          errors.add :base, "record is missing an email"
        end
      end

      def record_has_org_unit
        if record.org_unit.nil?
          errors.add :base, "record needs to be assigned to an OrgUnit"
        end
      end

    end

  end
end
