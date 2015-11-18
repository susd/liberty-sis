module Students
  class ContactsController

    def index
      @contacts = @student.contacts.order(:position)
    end

    private

    def set_student
      @student = Student.find(params[:student_id])
    end
  end
end
