class Api::V1::EventsController < Api::V1::BaseController
  # before_action :set_event, only: [ :show ]

  def index
    @events = Event.all
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end
end
