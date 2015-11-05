require 'test_helper'

class TeacherDispatcherTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers

  test "Send teachers with one classroom to their class page" do
    assert_equal classroom_path(classrooms(:ashleys_class)), TeacherDispatcher.new(employees(:ashley_doe)).path
  end

  test "Send teachers with multiple classes to classroom index" do
    assert_equal classrooms_path, TeacherDispatcher.new(employees(:multi_teacher)).path
  end

  test "Send those who can view all classrooms to classroom index" do
    assert users(:rsp_teacher).can_generally?(:view, :site, :classrooms)
    assert_equal classrooms_path, TeacherDispatcher.new(employees(:rsp_teacher)).path
  end

  test "Employee without classrooms" do
    assert_not TeacherDispatcher.new(employees(:no_class)).dispatch?
  end

end
