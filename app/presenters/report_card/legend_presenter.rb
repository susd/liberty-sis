class ReportCard::LegendPresenter < BasePresenter
  presents :report_card

  def score_scale
    if %w{tk kinder primary}.include? report_card.form.renderer
      type = 'positional'
    else
      type = 'value'
    end

    tpl.render partial: "report_cards/legends/#{type}_score"
  end

  def effort_scale
    if %w{tk kinder}.include? report_card.form.renderer
      type = 'easy'
    else
      type = report_card.form.renderer
    end

    tpl.render partial: "report_cards/legends/#{type}_effort"
  end
end
