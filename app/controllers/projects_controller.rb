class ProjectsController < ApplicationController
  before_action :set_project, only: [:details, :users, :cards, :update, :destroy]

  layout 'dashboard'

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
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
    @project_users = @project.creator.projects.map {|p| p.users}.compact.uniq
    if Plan.find_by_plan_type('solo').subscriptions.not_expired.map {|sub| sub.project}.compact.include?(@project)
      @can_add_user = false
    end

    if Plan.where('plan_type != ?', 'solo').map{|p| p.subscriptions.not_expired}.compact.map {|sub| sub.project}.compact.include?(@project)
      @can_add_user = true
    end

    # if @project.creator.is_a?(Organization)
    #   @project.creator.subscriptions.not_expired.includes(:plan).last.plan.no_of_users
    # else
    #   @project.creator.subscriptions.not_expired.includes(:plan)
    # end
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
