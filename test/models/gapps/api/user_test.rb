require "test_helper"

class Gapps::Api::UserTest < ActiveSupport::TestCase
  def setup
    stub_request(:any, /googleapis.com/).to_rack(FakeGoogle)
  end

  test "finding by email" do
    Gapps::Api::User.find("jane@example.org")

    assert_requested :get, "#{url_base}/jane@example.org"
  end

  test "inserting a user account for a student" do
    student = students(:cindy)
    api_student = Gapps::Api::User.new(student)
    expected_body = {
      primary_email: student.persona_email,
      password: student.persona_init_password,
      name: {
        family_name: student.last_name,
        given_name: student.first_name,
        full_name: student.name
      },
      org_unit_path: "/students",
      external_ids: [
        {
          "type" => "custom",
          "customType" => "person_id",
          "value" => student.id
        },
        {
          "type" => "custom",
          "customType" => "school_id",
          "value" => student.site.code
        },
        {
          "type" => "custom",
          "customType" => "grade",
          "value" => student.grade.simple
        }
      ],
      include_in_global_address_list: false
    }

    api_student.insert
    # assert_requested :post, "#{url_base}/jane@example.org"
  end

  private

  def url_base
    "https://www.googleapis.com/admin/directory/v1/users"
  end
end
