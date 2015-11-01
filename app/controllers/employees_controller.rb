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
end
