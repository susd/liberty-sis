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
    case
    when user.can_generally?(:view, :all, :sites)
      relation
    when user.can_generally?(:view, :own, :sites)
      relation.where(id: employee.sites.select(:id))
    else
      relation.where(id: employee.primary_site_id)
    end
    relation.order(:code)
  end
end
