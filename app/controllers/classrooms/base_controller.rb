module Classrooms
  class BaseController < ApplicationController
    after_action :authorize_classroom

    private

    def set_classroom
      @classroom = Classroom.find(params[:classroom_id])
    end

    def authorize_classroom
      authorize_to(:manage, @classroom)
    end
  end
end
