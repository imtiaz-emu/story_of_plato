class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  before_action :check_expiary, only: [:edit, :update]

  layout 'dashboard'

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @user_subscriptions = current_user.subscriptions
    @org_subscriptions = Subscription.where(plan_subscriber_type: 'Organization').includes(:plan_subscriber, :plan)
                             .map {|sub| sub if sub.plan_subscriber.created_by == current_user.id}.compact
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription.start_date <= DateTime.now && @subscription.end_date >= DateTime.now ? @expired = false : @expired = true
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        flash[:success] = 'Subscription was successfully created.'
        format.html { redirect_to @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    previous_subscription = @subscription
    respond_to do |format|
      if @subscription.update(subscription_params)
        @subscription.update_cost(previous_subscription)
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription = Subscription.includes(:plan, :plan_subscriber).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params.require(:subscription).permit(:plan_subscriber_id, :plan_subscriber_type, :plan_id, :duration_type, :duration)
  end

  def check_expiary

  end
end
