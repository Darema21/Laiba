class Api::V1::EventsController < Api::V1::BaseController
  before_action :set_event, only: [ :show, :update, :destroy ]

  def index
    @events = policy_scope(Event).all
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    authorize @event

    if @event.save
      render :show, status: :created
    else
      render_error
    end
  end

  def edit

  end

  def show
    # authorize @event
    @booking = Booking.new
  end

  def update
    # authorize @event

    if @event.update(event_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    # authorize @event
    @event.destroy
    head :no_content
  end

  private

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def event_params
    params.require(:event).permit(:title, :description, :address, :start_time, :end_time)
  end

  def render_error
    render json: { errors: @event.errors.full_messages },
    status: :unprocessable_entity
  end
end
