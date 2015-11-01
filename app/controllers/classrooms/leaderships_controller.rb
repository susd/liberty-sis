module Classrooms
  class LeadershipsController < BaseController
    before_action :set_classroom

    def index
      @leaderships = @classroom.classroom_leaderships.includes(:employee)
      @new_leadership = @classroom.classroom_leaderships.new
    end

    def create
      @leadership = @classroom.classroom_leaderships.new(leadership_params)
      if @leadership.save
        redirect_to classroom_leaderships_path(@classroom), notice: 'Teacher added'
      else
        redirect_to classroom_leaderships_path(@classroom), notice: 'Teacher could not be added'
      end
    end

    def destroy
      @leadership = @classroom.classroom_leaderships.find(params[:id])
      @leadership.destroy

      redirect_to classroom_leaderships_path(@classroom), notice: 'Teacher removed'
    end

    private

    def leadership_params
      params.require(:classroom_leadership).permit(:employee_id).merge(classroom: @classroom)
    end
  end
end
