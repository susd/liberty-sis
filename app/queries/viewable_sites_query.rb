class ViewableSitesQuery
  attr_reader :user, :relation, :employee

  def initialize(current_user, sites_relation = Site.all)
    @user = current_user
    @relation = sites_relation
    @employee = @user.employee
  end

  def sites
    if employee.nil?
      relation.none
    else
      scoped_sites
    end
  end

  def scoped_sites
    criteria = relation
    if user.can_generally?(:view, :all, :sites)
      criteria
    else
      criteria = relation.merge( relation.where(id: employee.sites.select(:id)) )
    end
    criteria.order(:code)
  end
end
