class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find(params[:id])
    @booked_events = User.find_by(id:1).booked_events
    render json: user, include: [:events, :bookings, :booked_events]
    # render json: user, include: [:events => {:include => bookings}, :bookings => {:include => :event}]
  end

  def promoters
    @promoters = User.for_hire
    render json: @promoters
  end

  def update_for_hire
    user = User.find(params[:id])
      self.for_hire = user.events.count >= 3 && user.events.bookings.count >= 20
      user.save

    render json: user
  end
end
