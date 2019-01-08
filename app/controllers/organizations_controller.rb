class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy, :add_user]

  layout 'dashboard'

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = current_user.organizations
    @owned_orgs = Organization.owned_organizations(current_user.id).includes(:users)
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @owner = @organization.owner
    @org_users = @organization.users
    @active_subscriptions = @organization.subscriptions.not_expired.includes(:plan)
                                .map{|sub| sub if ['startup', 'enterprise'].include?(sub.plan.plan_type)}.compact
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    @organization.owner = current_user

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_user
    user = User.find_by_email(params[:email])
    if user
      if (@organization.owner == user) || (@organization.users.include?(user))
        flash[:info] = "User Already Exists!"
        redirect_to organization_path(@organization)
      else
        @organization.users << user
        flash[:success] = "User #{params[:email]} added to #{@organization.name}"
        redirect_to organization_path(@organization)
      end
    else
      flash[:danger] = "User #{params[:email]} not found!"
      redirect_to organization_path(@organization)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_params
    params.require(:organization).permit(:name, :description)
  end
end
