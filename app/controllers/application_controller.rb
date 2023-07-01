class ApplicationController < ActionController::Base
  before_action :verify_authenticity_token

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
