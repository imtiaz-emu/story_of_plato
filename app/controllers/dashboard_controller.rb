class DashboardController < ApplicationController

  layout 'dashboard'

  def index
    @organizations = current_user.organizations
  end

end
