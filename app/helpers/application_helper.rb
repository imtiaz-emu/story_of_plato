module ApplicationHelper

  def current_user_organizations
    return Organization.owned_organizations(current_user.id)
  end

  def active_plans
    Plan.active
  end

end
