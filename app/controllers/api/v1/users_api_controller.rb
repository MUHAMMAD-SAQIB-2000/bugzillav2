class Api::V1::UsersApiController < Api::V1::ApplicationController

  # skip_before_action :verify_authenticity_token, only: [:create]
  # skip_before_action :authenticate_request , only: [:create]
  skip_before_action :verify_authenticity_token, only: [:index, :show, :create, :update, :destroy], raise: false

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    if @user != nil
      render json: @user
    end
  end

  def create
    @user = User.create(user_params)
    if @user.save
      render json: @user
    else
      render json: {error: 'No Authentication Token Found. User Not Created'}, status: :forbidden
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.user_projects.destroy_all
    @user.delete
  end

  def user_params
    params.require(:users_api).permit(:name, :password, :email, :user_type)
  end
end
