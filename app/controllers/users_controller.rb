class UsersController < ApplicationController
  load_and_authorize_resource :class => User

  def index
    # byebug
    if user_signed_in?
      @users = User.where.not("user_type = ?", 'Manager')
    else
      redirect_to home_path
    end
  end

  def show
    # byebug
    # byebug
    if user_signed_in?
      @projects = []
      @user_project = UserProject.new()
      @user = User.find(params[:id])

      if @user.user_type == 'Developer' || @user.user_type == 'QA' then

        @user_projects = UserProject.where('user_id = ?', @user.id)
        @user_projects.each { |user_project| @projects.append(Project.find(user_project.project_id)) }
      elsif @user.user_type == 'Manager' then
        @user_project = UserProject.new
        @projects = Project.where('user_id = ?', @user.id)
      end
    else
      redirect_to users_sign_in_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to root_url, status: :see_other
  end

  def user_search
    if params.has_key?(:term)
      @users = []
      if current_user.user_type == 'QA'
        @users = User.search(params[:term]).where('user_type = ?', 'Developer')
      else
        @users = User.search(params[:term])
      end

      if @users != nil
        # flash[:notice] = "Visible? #{@users.first.name}"
        params[:term] = ""
        render json: @users
      end
    else
      # flash[:alert] = "No Params"
    end
  end

  def assign_project
    @user = User.find(params[:id])
    @project = Project.find(params[:id])

    @user_project = UserProject.create(user: @user, project: @project)
    # flash[:notice] = "Hi!! Plz Work :( #{@user_project.id}"
    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email, :user_type)
  end

  def user_project_params
    params.require(:user_project).permit(:user_id, :project_id)
  end
end

# end

