require 'test_helper'

class EmployeeDispatcherTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers

  test "Send teachers with one classroom to their class page" do
    assert_equal classroom_path(classrooms(:ashleys_class)), EmployeeDispatcher.new(employees(:ashley_doe)).path
  end

  test "Send teachers with multiple classes to classroom index" do
    assert_equal classrooms_path, EmployeeDispatcher.new(employees(:multi_teacher)).path
  end

  test "Employee without classrooms" do
    assert_not EmployeeDispatcher.new(employees(:no_class)).dispatch?
  end

end
