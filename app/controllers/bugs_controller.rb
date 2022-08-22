class BugsController < ApplicationController
  # load_and_authorize_resource #:class => Bug, :nested => Project

  def index
    @bugs = []
    if user_signed_in?
      if current_user.user_type == 'Developer' then
        @bugs = Bug.where("assigned_to = ?", current_user.id)

      elsif current_user.user_type == 'Manager' then

        projects = Project.where('user_id = ?', current_user.id)
        projects.each { |project|
          bug = Bug.find_by_project_id(project.id)
          if bug != nil
            @bugs.append(bug)
          end
        }
      elsif current_user.user_type == 'QA' then
        @bugs = Bug.all
      end
      # end

    end
  end

  def show
    # byebug
    @user = nil
    @bug = Bug.find(params[:id])
    @project = Project.find(@bug.project_id)

    if @bug.assigned_to != 0
      if @bug.user_id == current_user.id
        @user = User.find(@bug.assigned_to)
      elsif @bug.assigned_to == current_user.id
        @user = User.find(@bug.user_id)
      end
    end
  end

  def new
    @users = User.where('user_type = ? ', 'Developer')

    # @projects = current_user.projects
    @projects = []
    @bug = Bug.new
    if params.has_key?(:project_id)
      project = Project.find(params[:project_id])
      @bug.project_id = project.id
    end
  end

  def create
    # byebug
    @bug = Bug.create(bugs_params)
    if @bug.save
      flash[:notice] = "Bug was successfully created. #{params[:user_id]}"
      redirect_to @bug
    else
      flash[:alert] = "Failed to Create Bug!"
      redirect_to new_bug_path
    end
  end

  def edit
    @bug = Bug.find(params[:id])
    @users = User.where('user_type = ?', 'Developer')
    @projects = current_user.projects
  end

  def update
    @bugs = Bug.find(params[:id])
    if @bugs.update(bugs_params)
      redirect_to @bugs
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bug = Bug.find(params[:id])
    if @bug.delete
      flash[:success] = "Bug Deleted #{@bug.title}"
      redirect_to bugs_path, status: :see_other
    else
      flash[:alert] = "Failed to Delete Bug!"
      redirect_to bug_path(@bug), status: :unprocessable_entity
    end
  end

  def assign_to
    @bug = Bug.find(params[:id])
    if @bug.assigned_to == 0
      @bug.assigned_to = current_user.id
      @bug.save
      flash[:success] = "Bug Assigned to You!"
      redirect_to @bug
    else
    end
  end

  def change_status
    @bug = Bug.find(params[:id])
    bug_status = params[:bug_status].to_s
    @bug.update_attribute(:bug_status, bug_status)
    if @bug.save
      flash[:notice] = "Status Updated! #{bug_status}"
      redirect_to @bug
    else
      flash.alert = "Status Not Updated!"
      redirect_to @bug
    end
  end

  private

  def bugs_params
    # byebug
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :bug_type, :bug_status, :assigned_to, :project_id, :user_id)
  end
end
