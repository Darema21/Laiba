class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find(params[:id])
    @booked_events = User.find_by(id:1).booked_events
    @recieved_bookings = User.find_by(id:1).recieved_bookings
    render json: user, include: [:events, :bookings, :booked_events, :recieved_bookings]
  end

  def promoters
    @promoters = User.for_hire
    render json: @promoters, include: [:id, :nickname], include: { events: {}, recieved_bookings: {} }
  end

end
