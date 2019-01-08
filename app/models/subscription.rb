class Subscription < ApplicationRecord

  belongs_to :plan_subscriber, polymorphic: true
  belongs_to :plan
  belongs_to :project, optional: true

  after_validation :set_expiray_and_cost
  before_save :check_if_subscription_exists
  after_create :create_project, if: -> (subscription){subscription.plan.plan_type == 'solo' }

  private
  def set_expiray_and_cost
    self.start_date = DateTime.now
    if self.duration_type == 'Annually'
      self.duration = self.duration * 12
      self.total_cost = self.duration * self.plan.annual_price
    else
      self.total_cost = self.duration * self.plan.monthly_price
    end
    self.end_date = DateTime.now + self.duration.months
  end

  def check_if_subscription_exists
    if self.plan_subscriber.is_a?(Organization) && self.plan_subscriber.subscriptions.count > 0
      errors.add(:base, "You've already bought a subscription for this organization!")
      throw(:abort)
    end
  end

  def create_project
    self.plan_subscriber.projects.create(name: 'Default Project')
  end

end
