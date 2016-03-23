module Gapps
  module Api

    class User < Base
      def self.find(email)
        service.get_user(email)
      end

      attr_reader :user, :persona

      def initialize(native_user)
        @user = native_user
        @persona = find_or_create_persona
      end

      def insert
        SyncEvent.wrap(label: "gapps:user", action: 1, syncable: persona) do
          service_insert
        end
      end

      private

      def find_or_create_persona
        @user.personas.find_or_create_by(handler: "gapps")
      end

      def service_insert
        service.insert_user(native_to_api) do |resp, err|
          if err
            Rails.logger.error err
            false
          else
            @persona.update(state: 1, service_id: resp.id)
          end
        end
      end

      def native_to_api
        GAdmin::User.new({
          primary_email: persona.username,
          password: persona.password,
          name: {
            family_name: user.last_name,
            given_name: user.first_name,
            full_name: user.name
          },
          org_unit_path: org_path,
          external_ids: external_ids,
          include_in_global_address_list: false
        })
      end

      def external_ids
        xids = [
          {
            "type" => "custom",
            "customType" => "person_id",
            "value" => user.id
          }
        ]

        case user.class
        when Student
          xids += [
            {
              "type" => "custom",
              "customType" => "school_id",
              "value" => user.site.code
            },
            {
              "type" => "custom",
              "customType" => "grade",
              "value" => user.grade.simple
            }
          ]
        when Employee
          xids += [
            {
              "type" => "custom",
              "customType" => "school_id",
              "value" => user.primary_site.code
            }
          ]
        end

        xids
      end

      def org_path
        # determine from org_unit
      end

    end

  end
end
