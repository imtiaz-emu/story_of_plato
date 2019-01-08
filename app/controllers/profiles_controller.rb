class ProfilesController < ApplicationController

  layout 'dashboard'

  def show
    @user = User.find(params[:id])
    @active_subscriptions = @user.subscriptions.not_expired.includes(:plan)
                                .map{|sub| sub if ['startup', 'enterprise'].include?(sub.plan.plan_type)}.compact
  end

end
