module ApplicationHelper

  def current_user_organizations
    return Organization.owned_organizations(current_user.id)
  end

  def active_plans
    Plan.active
  end

  def project_creator(project)
    return project.creator.is_a?(Organization) ? project.creator.name : project.creator.email
  end

end
