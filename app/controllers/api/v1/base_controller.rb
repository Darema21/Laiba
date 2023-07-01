# app/controllers/api/v1/base_controller.rb
class Api::V1::BaseController < ActionController::Base
  # rescue_from StandardError,                with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  HMAC_SECRET = Rails.application.credentials.dig(:jwt, :hmac_secret)
  skip_before_action :verify_authenticity_token
  before_action :verify_request

  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def pundit_user
    @current_user
  end


  private

  def verify_request
    token = get_jwt_token
    if token.present?
      data = jwt_decode(token)
      user_id = data[:user_id]
      @current_user = User.find(user_id) # set current user by user_id in JWT payload
      puts "@current_user #{@current_user.id}"
    else
      render json: { error: 'Missing JWT token.' }, status: 401
    end
  end

  # decode JWT, then turn payload into a hash
  def jwt_decode(token)
    decoded_info = JWT.decode(token, HMAC_SECRET, { algorithm: 'HS256' })[0] # extract the payload
    HashWithIndifferentAccess.new decoded_info
  end

  # retrieve token from headers
  def get_jwt_token
    puts " request.headers['X-USER-TOKEN'] #{request.headers['X-USER-TOKEN']}"
    request.headers['X-USER-TOKEN']
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def skip_pundit?
    params[:controller] =~ /(^(rails_)?admin)|(^sessions$)/
  end

  # def internal_server_error(exception)
  #   if Rails.env.development?
  #     response = { type: exception.class.to_s, error: exception.message }
  #   else
  #     response = { error: 'Internal Server Error' }
  #   end
  #   render json: response, status: :internal_server_error
  # end
end
