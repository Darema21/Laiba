class Api::V1::EventsController < Api::V1::BaseController
  before_action :set_event, only: [ :show, :update, :destroy ]

  def index
    @events = Event.all
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render :show, status: :created
    else
      render_error
    end
  end


  def show
    # render json: @event
    render json: {
      id: @event.id,
      title: @event.title,
      description: @event.description,
      address: @event.address,
      user_id: @event.user_id,
      start_time: @event.start_time.strftime('%b %d, %Y'),
      end_time: @event.end_time.strftime('%b %d, %Y')
    }
  end

  def update
    if @event.update(event_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @event.destroy
    head :no_content
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :address, :start_time, :end_time)
  end

  def render_error
    render json: { errors: @event.errors.full_messages },
    status: :unprocessable_entity
  end

end
