class ProjectsController < ApplicationController
  before_action :set_project, only: [:details, :users, :cards, :update, :destroy, :add_user, :remove_user]

  layout 'dashboard'

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def details
    if @project.creator.is_a?(User)
      @project_owner = @project.creator == current_user
    else
      @project_owner = Organization.owned_organizations(current_user.id).include?(@project.creator)
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def users
    @project_users = @project.users
    plans = Plan.other_than_solo.pluck(:id)
    begin
      subscription = @project.creator.subscriptions.not_expired.where('plan_id IN (?)', plans).includes(:plan).last
      @can_add_user = subscription ? true : false
    rescue
      @can_add_user = false
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to details_project_path(@project), notice: 'Project was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to details_project_path(@project), notice: 'Project was successfully updated.' }
      else
        format.html { render :users }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_user
    user = User.find_by_email(params[:email])
    if user
      if @project.users.include?(user)
        flash[:info] = 'User already exists!'
      else
        @project.add_user(user)
        flash[:success] = "User successfully added!"
      end
    else
      flash[:info] = "No user found with email #{params[:email]}."
    end
    redirect_to users_project_path(@project)
  end

  def remove_user
    user = User.find(params[:user_id])
    project_creator = @project.creator.is_a?(Organization) ? @project.creator.owner : @project.creator
    if project_creator == user
      flash[:info] = 'Cannot delete Project creator'
    else
      @project.users.delete(user)
      flash[:success] = "User successfully removed!"
    end
    redirect_to users_project_path(@project)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :creator_id, :creator_type)
  end
end
