module Classrooms
  class MembershipsController < BaseController

    def index
      set_classroom
      @memberships = @classroom.classroom_memberships.includes(:student)
    end

    def destroy
      set_classroom
      @membership = @classroom.classroom_memberships.find(params[:id])
      @membership.destroy

      redirect_to classroom_memberships_path(@classroom), notice: 'Student removed'
    end
  end
end
