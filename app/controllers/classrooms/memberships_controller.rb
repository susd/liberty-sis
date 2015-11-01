module Classrooms
  class MembershipsController < BaseController
    before_action :set_classroom

    def index
      @memberships = @classroom.classroom_memberships.includes(:student)
    end

    def destroy
      @membership = @classroom.classroom_memberships.find(params[:id])
      @membership.destroy

      redirect_to classroom_memberships_path(@classroom), notice: 'Student removed'
    end
  end
end
