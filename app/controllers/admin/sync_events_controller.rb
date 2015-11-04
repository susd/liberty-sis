class Admin::SyncEventsController < AdminController
  def index
    @sync_events = SyncEvent.order(updated_at: :desc).page(params[:page]).per(40)
  end
end
