# == Schema Information
#
# Table name: personas
#
#  id              :integer          not null, primary key
#  student_id      :integer
#  handler         :string
#  username        :string
#  password        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  state           :integer          default(0), not null
#  service_id      :string
#  service_data    :jsonb            not null
#  synced_at       :datetime
#  personable_id   :integer
#  personable_type :string           default("Student")
#

module Students
  class PersonasController < ApplicationController
    before_action :set_student
    after_action :authorize_persona

    def index
      @personas = @student.personas.order(:handler)
    end

    def new
      @persona = @student.personas.new(username: @student.persona_email, password: @student.persona_init_password)
    end

    def edit
      set_persona
    end

    def create
      @persona = @student.personas.new(persona_params)
      if @persona.save
        redirect_to student_personas_path(@student), notice: 'Account created.'
      else
        render :new
      end
    end

    def update
      set_persona
      if @persona.update(persona_params)
        redirect_to student_personas_path(@student), notice: 'Account updated.'
      else
        render :edit
      end
    end

    def sync
      @persona = @student.personas.find(params[:id])
      if @persona.handler == 'gapps'
        SyncGappsPersonaJob.perform_later(@student)
        redirect_to student_personas_path(@student), notice: "Account scheduled to be synced."
      else
        redirect_to student_personas_path(@student), alert: "Can't sync #{@persona.handler}"
      end
    end

    private

    def set_student
      @student = Student.find(params[:student_id])
    end

    def set_persona
      @persona = @student.personas.find(params[:id])
    end

    def persona_params
      params.require(:persona).permit(:username, :password, :handler)
    end

    def authorize_persona
      authorize_to(:manage, @student)
    end
  end

end
