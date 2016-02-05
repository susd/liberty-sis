require 'test_helper'

class PrincipalEvaluationTest < ActionDispatch::IntegrationTest

  # As a principal

  # I want to login
  # See a link for employees

  test "View employee" do
    with_user(users(:principal)) do
      visit "/"
      assert page.has_link? 'employees'
    end
  end

  test "Seeing a list of employees" do
    skip
  end

  # I want to view a teacher
  # - from my school
  # - see her info
  # - see a list of evaluations

  test "Viewing a teacher" do
    skip
  end

  # I want to
  # - fill out an evaluation
  # - save the evaluation
  # - edit the evaluation
  # -- if by a certain date?

  test "Doing an evaluation" do
    skip
  end

end
