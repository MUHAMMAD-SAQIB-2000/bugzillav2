class ProjectsController < ApplicationController
  load_and_authorize_resource :class => Project
  require 'pagy'

  def index

    if user_signed_in?
      @projects = []

      if current_user.user_type == 'Manager' then
        @projects = Project.where('user_id = ?', current_user.id)
      elsif current_user.user_type == 'Developer' || current_user.user_type == 'QA' then
        # byebug
        @projects = current_user.projects
      end
      # .search(params[:search])
      @pagy, @projects = pagy(@projects, items: 4)
    end
  end

  def new
    @new = true
    @users = User.where('user_type != ?', current_user.user_type)

    @project = Project.new
    @project.user_projects.build
  end

  def create
    @project = Project.create(project_params_nested)

    if @project.save
      # @project.update(project_params_nested)
      flash[:notice] = "Project Created! #{@project.name}"
      redirect_to project_path(@project)
    else
      redirect_to new_project_url
    end
  end

  def show
    @project = Project.find(params[:id])
    @user = User.find(@project.user_id)

    if user_signed_in?
      if current_user.user_type == 'Manager'
        @users = @project.users
      end
    end
  end

  def edit
    @new = false
    @project = Project.find(params[:id])
    @users = User.where('user_type != ?', current_user.user_type)
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params_nested)
      flash[:notice] = "Project Updated!"
      redirect_to @project
    else
      flash[:alert] = "Project Not Updated! #{@project.users.size}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    byebug
    @project = Project.find(params[:id])
    Bug.where(:project_id => @project.id).destroy_all
    # UserProject.where(:project_id => @project.id).destroy_all
    @project.delete
    redirect_to projects_path, status: :see_other
  end

  def project_search
    if params.has_key?(:term)
      @projects = []
      if params[:term] != ""
        @projects = Project.search(params[:term])
        if @projects != nil
          # flash[:notice] = "Visible? #{@projects.first.name}"
          params[:term] = nil
          render json: @projects
        end
      else
        @projects = []
      end

    else
      # flash[:alert] = "No Params"
    end
  end

  private

  def project_params
    params.require(:project)
          .permit(:name, :description, :user_id)
  end

  def project_params_nested
    params.require(:project)
          .permit(:name, :description, :user_id, user_projects_attributes: [:id, :_destroy, :user_id]
          )
  end
end
