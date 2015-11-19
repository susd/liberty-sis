module Students
  class ContactsController < ApplicationController
    before_action :set_student

    def index
      authorize_to(:view, @student)
      @contacts = @student.contacts.order(:position)
    end

    private

    def set_student
      @student = Student.find(params[:student_id])
    end
  end
end
