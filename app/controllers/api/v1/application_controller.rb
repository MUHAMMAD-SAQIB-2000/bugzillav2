class Api::V1::ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request

  private

  def authenticate_request

    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = jwt_decode(token)

    @current_user = User.find(decoded[:user_id])
    # byebug
  end
end