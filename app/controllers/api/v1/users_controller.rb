class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find(params[:id])
    render json: user, include: [:events, :bookings]
  end

  def promoters
    @promoters = User.for_hire
    render json: @promoters
  end

  def update_for_hire
    self.for_hire = events.counts > 3 && bookings.count >= 50
    save
  end
end
