module ReportCards
  class GradingPeriodsController < AdminController
    helper_method :period_form_path

    def index
      @grading_periods = ReportCard::GradingPeriod.order({year: :desc, position: :asc})
    end

    def new
      @grading_period = ReportCard::GradingPeriod.new
    end

    def create
      @grading_period = ReportCard::GradingPeriod.new(grading_period_params)
      if @grading_period.save
        redirect_to report_cards_grading_periods_path, notice: 'Period saved'
      else
        render :new
      end
    end

    def edit
      set_period
    end

    def update
      set_period
      if @grading_period.update(grading_period_params)
        redirect_to report_cards_grading_periods_path, notice: 'Period saved'
      else
        render :edit
      end
    end

    private

    def set_period
      @grading_period = ReportCard::GradingPeriod.find params[:id]
    end

    def grading_period_params
      params.require(:report_card_grading_period).permit(:year, :position, :starts_on, :ends_on)
    end

    def period_form_path(period)
      if period.persisted?
        report_cards_grading_period_path(period)
      else
        report_cards_grading_periods_path
      end
    end

  end
end
