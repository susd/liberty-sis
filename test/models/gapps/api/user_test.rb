require "test_helper"

class Gapps::Api::UserTest < ActiveSupport::TestCase
  def setup
    stub_request(:any, /googleapis.com/).to_rack(FakeGoogle)
  end

  test "finding by email" do
    Gapps::Api::User.find("jane@example.org")

    assert_requested :get, "#{url_base}/jane@example.org"
  end

  test "finding the persona for a student" do
    student = students(:cindy)
    persona = student.personas.create({
      handler: "gapps", username: student.persona_email,
      password: student.persona_init_password
      })

    api_student = Gapps::Api::User.new(persona)

    assert_kind_of Persona, api_student.persona
    assert_equal student.persona_email, api_student.persona.username
  end

  test "inserting a user account for a student" do
    student = students(:cindy)
    persona = student.personas.create({
      handler: "gapps", username: student.persona_email,
      password: student.persona_init_password
      })

    api_user = Gapps::Api::User.new(persona)

    api_user.insert
    assert_requested :post, url_base, body: expected_student_body(student, persona)
  end

  test "inserting a user account for an employee" do
    employee = employees(:ashley_doe)
    persona = employee.personas.create({
      handler: "gapps",
      username: employee.email,
      password: employee.persona_init_password
      })

    api_user = Gapps::Api::User.new(persona)

    api_user.insert
    assert_requested :post, url_base, body: expected_employee_body(employee, persona)
  end

  test "inserting an employee fails if email missing" do
    employee = employees(:teacher)
    persona = employee.personas.create({
      handler: "gapps",
      username: employee.email,
      password: employee.persona_init_password
      })

    api_user = Gapps::Api::User.new(persona)

    refute api_user.insert
  end

  test "patching an existing user" do
    student = students(:cindy)
    persona = student.personas.create({
      handler: "gapps", username: student.persona_email,
      password: student.persona_init_password,
      state: 1
      })

    api_user = Gapps::Api::User.new(persona)

    api_user.update
    assert_requested :patch, "#{url_base}/", body: expected_student_body(student, persona)
  end

  test "upserting" do
    student = students(:cindy)
    persona = student.personas.create({
      handler: "gapps", username: student.persona_email,
      password: student.persona_init_password,
      state: 1
      })

    api_user = Gapps::Api::User.new(persona)

    api_user.upsert
    assert_requested :patch, "#{url_base}/", body: expected_student_body(student, persona)
  end

  private

  def url_base
    "https://www.googleapis.com/admin/directory/v1/users"
  end

  def expected_student_body(student, persona)
    {
      "primaryEmail" => student.persona_email,
      "password" => student.persona_init_password,
      "name" => {
        "familyName" => student.last_name,
        "givenName" => student.first_name,
        "fullName" => student.name
      },
      "orgUnitPath" => "/students/grade_4",
      "externalIds" => [
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
      "includeInGlobalAddressList" => false
    }
  end

  def expected_employee_body(employee, persona)
    {
      "primaryEmail" => employee.email,
      "password" => employee.persona_init_password,
      "name" => {
        "familyName" => employee.last_name,
        "givenName" => employee.first_name,
        "fullName" => employee.name
      },
      "orgUnitPath" => "/employees",
      "externalIds" => [
        {
          "type" => "custom",
          "customType" => "person_id",
          "value" => employee.id
        },
        {
          "type" => "custom",
          "customType" => "school_id",
          "value" => employee.primary_site.code
        }
      ],
      "includeInGlobalAddressList" => true
    }
  end
end
