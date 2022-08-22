class ApplicationController < ActionController::Base
  include Pagy::Backend

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :user_type) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :user_type) }
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    if user_signed_in?
      redirect_to user_path(current_user)
    else
      redirect_to root_url
    end

  end

  def after_sign_in_path_for(resource)
    # byebug
    user_path(current_user)
    # projects_path
  end

  def after_sign_up_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource_or_scope)
    users_sign_in_path
  end

end
