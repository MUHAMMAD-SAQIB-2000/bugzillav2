class Api::V1::ApplicationController < ActionController::API
  # include JsonWebToken

  # before_action :authenticate_request
  # skip_before_action :verify_authenticity_token

  private

  def authenticate_request

    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = jwt_decode(token)

    @current_user = User.find(decoded[:user_id])
    # byebug
  end
end