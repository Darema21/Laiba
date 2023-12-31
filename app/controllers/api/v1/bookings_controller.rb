class Api::V1::BookingsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_event, only: :create
  # after_action :update_for_hire, only: [:create, :destroy]

  def create
    existing_booking = Booking.find_by(event_id: booking_params[:event_id], user_id: booking_params[:user_id])
    if existing_booking
      existing_booking.destroy
      render json: existing_booking.event
    else
      @booking = Booking.new(booking_params)
      if @booking.save
        render json: @booking.event
      else
        render "events/show", status: :unprocessable_entity
      end
    end
  end

  private

  def update_for_hire
    user = @booking.event.user
    user.update_for_hire
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def booking_params
    # { event_id: 1, user_id: 1 }
    # { booking: { event_id: 1, user_id: 1 } }
    params.require(:booking).permit(:event_id, :user_id)
  end
end
