require 'test_helper'

class EmployeeDispatcherTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers

  test "Send employees with one site to classrooms path" do
    assert_equal classrooms_path, EmployeeDispatcher.new(employees(:principal)).path
  end

  test "Send employees with multiple sites to sites path" do
    assert_equal sites_path, EmployeeDispatcher.new(employees(:rsp_teacher)).path
  end

end
