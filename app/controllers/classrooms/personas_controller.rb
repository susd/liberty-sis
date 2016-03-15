module Classrooms
  class PersonasController < ApplicationController
    before_action :set_classroom

    def index
      authorize_to(:view, @classroom)
      # @personas = Persona.where(student_id: @classroom.students).includes(:student)
      @students = @classroom.students.order(:last_name).includes(:personas)
    end

    private

    def set_classroom
      @classroom = Classroom.find(params[:classroom_id])
    end

  end
end
