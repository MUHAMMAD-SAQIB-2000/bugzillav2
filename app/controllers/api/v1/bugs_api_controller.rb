class Api::V1::BugsApiController < Api::V1::ApplicationController

  # skip_before_action :verify_authenticity_token, only: [:index, :show, :create, :update, :destroy]
  before_action :authenticate_request

  def index
    @bugs = Bug.all
    render json: @bugs
  end

  def show
    @bug = Bug.find(params[:id])
    if @bug != nil
      render json: @bug
    end

  end

  def create
    @bug = Bug.create(bugs_params)
    if @bug.save
      render json: @bug
    end
  end

  def update
    @bugs = Bug.find(params[:id])
    if @bugs.update(bugs_params)
      render json: @bug
    else
      render nil, status: :unprocessable_entity
    end
  end

  def destroy
    @bug = Bug.find(params[:id])
    render json: @bug.destroy
  end

  def bugs_params
    # byebug
    params.permit(:title, :description, :deadline, :screenshot, :bug_type, :bug_status, :assigned_to, :project_id, :user_id)
  end
end
