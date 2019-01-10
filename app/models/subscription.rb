class Subscription < ApplicationRecord

  belongs_to :plan_subscriber, polymorphic: true
  belongs_to :plan
  belongs_to :project, optional: true

  after_validation :set_expiray_and_cost
  before_save :check_if_subscription_exists
  after_create :create_project, if: -> (subscription){subscription.plan.plan_type == 'solo' }

  scope :not_expired, -> { where("start_date <= ? AND end_date >= ?", DateTime.now, DateTime.now)}


  def update_cost(prev_sub)
    self.start_date = DateTime.now
    if self.duration_type == 'Annually'
      self.duration = self.duration * 12
      self.total_cost = prev_sub.total_cost + self.duration * self.plan.annual_price
    else
      self.total_cost = prev_sub.total_cost + self.duration * self.plan.monthly_price
    end
    self.end_date = DateTime.now + self.duration.months
    self.save(validate: false)
  end

  private
  def set_expiray_and_cost
    if self.new_record?
      self.start_date = DateTime.now
      if self.duration_type == 'Annually'
        self.duration = self.duration * 12
        self.total_cost = self.duration * self.plan.annual_price
      else
        self.total_cost = self.duration * self.plan.monthly_price
      end
      self.end_date = DateTime.now + self.duration.months
    end
  end

  def check_if_subscription_exists
    if self.new_record?
      plans = Plan.other_than_solo.pluck(:id)
      if self.plan_subscriber.subscriptions.where('plan_id IN (?)', plans).count > 0
        errors.add(:base, "You've already bought a subscription of package for this organization!")
        throw(:abort)
      end
    end
  end

  def create_project
    project = self.plan_subscriber.projects.create(name: 'Default Project')
    self.update_attribute(:project_id, project.id)
  end

end
