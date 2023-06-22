class Api::V1::BookingsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_event, only: :create

  def create
    @booking = @event.bookings.build(booking_params)
    if @booking.save
      redirect_to event_path(@event)
    else
      render 'events/show', status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to event_path(@booking.event), status: :see_other
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:event_id, :user_id)
  end
end
