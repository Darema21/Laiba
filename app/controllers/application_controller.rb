class ApplicationController < ActionController::Base
  before_action :verify_authenticity_token
end
