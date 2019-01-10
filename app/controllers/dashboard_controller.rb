class DashboardController < ApplicationController

  layout 'dashboard'

  def index
    @organizations = current_user.organizations.includes(:users)
    @projects = current_user.projects.includes(:users, :cards)
    @subscriptions = current_user.subscriptions
  end

end
