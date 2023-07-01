class Api::V1::EventsController < Api::V1::BaseController
  before_action :set_event, only: [ :show, :update, :destroy, :upload_image ]
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  def index
    @events = Event.all
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      current_user.update_for_hire_status
      render :show, status: :created
    else
      render_error
    end
  end

  def upload_image

  end

  def show
    @booking = Booking.new
  end

  def update
    if @event.update(event_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    if @event.destroy
      head :no_content
    else
      render_error
    end
  end

  def category
    category = params[:category]
    @events = Event.where(category: category)
    render :index
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :address, :start_time, :end_time, :category, :user_id, :image)
  end

  def render_error
    render json: { errors: @event.errors.full_messages },
    status: :unprocessable_entity
  end

end

# darema 6.29 line 52 added :image
