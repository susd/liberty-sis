class ViewableClassroomsQuery
  attr_reader :user, :employee, :relation

  def initialize(current_user, classroom_relation = Classroom.all)
    @user = current_user
    @employee = current_user.employee
    @relation = classroom_relation
  end

  def user_classrooms
    if employee.nil?
      relation.none
    else
      scoped_classrooms
    end
  end

  private

  def scoped_classrooms
    case
    when user.can_generally?(:view, :all, :classrooms)
      relation.order(:site_id, :name)
    when user.can_generally?(:view, :site, :classrooms)
      relation.where(site: employee.sites).order(:site_id, :name)
    else
      relation.where(id: employee.classrooms).order(:name)
    end
  end
end