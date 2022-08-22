class HomeController < ApplicationController
  def index
    # byebug
    if user_signed_in?
      redirect_to user_path(current_user)
    else
      redirect_to users_sign_in_path
    end
  end
end
