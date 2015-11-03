module PersonaHelper
  def sync_button(student, persona)
    if persona.behind?
      link_to 'Sync', sync_student_persona_path(student, persona), method: :patch, class: 'btn btn-default btn-sm'
    end
  end

end
