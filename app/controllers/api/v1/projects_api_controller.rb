class Api::V1::ProjectsApiController < Api::V1::ApplicationController

  # skip_before_action :verify_authenticity_token, only: [:index, :show, :create, :update, :destroy]
  before_action :authenticate_request

  def index
    @projects = Project.all
    render json: @projects
  end

  def show
    @project = Project.find(params[:id])
    if @project != nil then
      render json: @project
    end
  end

  def create
    @project = Project.create(project_params_nested)
    if @project.save
      render json: @project
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params_nested)
      render json: @project
    end
  end

  def destroy
    # byebug
    @project = Project.find(params[:id])
    Bug.where(:project_id => @project.id).destroy_all
    @project.user_projects.destroy_all
    @project.delete
  end

  private

  def project_params
    params.require(:project)
          .permit(:name, :description, :user_id)
  end

  def project_params_nested
    params.permit(:name, :description, :user_id, user_projects_attributes: [:id, :_destroy, :user_id])
  end
end
