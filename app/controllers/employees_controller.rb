# == Schema Information
#
# Table name: employees
#
#  id              :integer          not null, primary key
#  type            :string
#  first_name      :string
#  last_name       :string
#  sex             :string
#  email           :string
#  birthdate       :date
#  hired_on        :date
#  years_edu       :integer          default(0), not null
#  years_district  :integer          default(0), not null
#  title           :string
#  state           :integer          default(0), not null
#  legacy_id       :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  import_details  :jsonb            not null
#  primary_site_id :integer
#

class EmployeesController < ApplicationController
  def search
    query = params[:term] || params[:query]
    @employees = Employee.includes(:primary_site).admin_search(query).limit(50)
    respond_to do |format|
      format.json do
        render json: @employees.map{|e| {id: e.id, value: "#{e.first_name} #{e.last_name}"}}
      end
      format.js
    end

    authorize_general(:view, :site, :employees)
  end

  def index
    # @employees = ViewableEmployeesQuery.new(current_user).employees
  end
end
