module Gapps
  class Student < Base

    def self.find(email)
      service = GAdmin::DirectoryService.new
      service.get_user(email)
    end

    # FIXME: Batch requests do not update persona and generate quota errors
    # def self.batch_upsert!(student_relation)
    #   student_relation.includes(:personas, :site, :grade).find_in_batches do |group|
    #     service.batch do |service|
    #       group.each do |student|
    #         new(student).upsert!
    #       end
    #     end
    #   end
    # end

    def self.upsert_all!(student_relation)
      student_relation.find_each do |student|
        SyncGappsPersonaJob.perform_later(student)
      end
    end

    def initialize(student)
      @student = student
      @persona = student.personas.find_by(handler: 'gapps')
    end

    def insert!
      service.insert_user(dir_user(student_attrs)) do |resp, err|
        if err
          Rails.logger.error err
        else
          @persona.update(state: 1, service_id: resp.id)
        end
      end
    end

    def update!
      service.patch_user(@persona.service_id, dir_user(student_attrs)) do |resp, err|
        if err
          Rails.logger.error err
        else
          @persona.touch(:synced_at)
        end
      end
    end

    def get
      begin
        if @persona.service_id.present?
          service.get_user(@persona.service_id)
        else
          service.get_user(@student.persona_email)
        end
      rescue Google::Apis::Error => e
        return nil
      end
    end

    def upsert!
      if @persona.active?
        update!
      else
        insert!
      end
    end

    def delete!
      if @persona.active?
        service.delete_user(@persona.service_id)
        @persona.update(state: 0)
      else
        false
      end
    end

    def dir_user(attrs)
      GAdmin::User.new(attrs)
    end

    def student_attrs
      {
        primary_email: @persona.username,
        password: @persona.password,
        name: {
          family_name: @student.last_name,
          given_name: @student.first_name,
          full_name: @student.name
        },
        org_unit_path: "/Students",
        external_ids: [
          {
            "type" => "custom",
            "customType" => "person_id",
            "value" => @student.id
          },
          {
            "type" => "custom",
            "customType" => "school_id",
            "value" => @student.site.code
          },
          {
            "type" => "custom",
            "customType" => "grade",
            "value" => @student.grade.simple
          }
        ],
        include_in_global_address_list: false
      }
    end

  end
end


# {
#   :agreed_to_terms=>true,
#   :aliases=>["jtmcfakerton23@saugususd.org"],
#   :change_password_at_next_login=>false,
#   :creation_time=>Thu, 23 Jul 2015 20:05:22 +0000,
#   :customer_id=>"C03tx5gt0",
#   :emails=>[{:address=>"jtmcfakerton23@em.saugususd.org", :primary=>true}, {:address=>"jtmcfakerton23@saugus.k12.ca.us"}, {:address=>"jtmcfakerton23@saugususd.org"}],
#   :etag=>"\"CAca-r_AOtaWjq33oriROyUcbFY/Tnaczk7pMexsnpKg5LaTP_M1i7E\"",
#   :external_ids=>[{:value=>"1", :type=>"custom", :customType=>"person_id"}, {:value=>"15", :type=>"custom", :customType=>"school_id"}, {:value=>"4", :type=>"custom", :customType=>"grade"}],
#   :id=>"111799955881910831512",
#   :include_in_global_address_list=>true,
#   :ip_whitelisted=>false,
#   :is_admin=>false,
#   :is_delegated_admin=>false,
#   :is_mailbox_setup=>true,
#   :kind=>"admin#directory#user",
#   :last_login_time=>Thu, 01 Jan 1970 00:00:00 +0000,
#   :name=>{:family_name=>"McFakerton", :full_name=>"Jonathan McFakerton", :given_name=>"Jonathan"},
#   :non_editable_aliases=>["jtmcfakerton23@saugus.k12.ca.us"],
#   :org_unit_path=>"/",
#   :primary_email=>"jtmcfakerton23@em.saugususd.org",
#   :suspended=>false
# }
