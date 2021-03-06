class Project < ApplicationRecord

  belongs_to :creator, polymorphic: true
  has_many :subscriptions
  has_many :cards, :dependent => :destroy
  has_many :project_users
  has_many :users, through: :project_users


  after_create :add_owner_as_user


  def add_user(user)
    plans = Plan.other_than_solo.pluck(:id)
    subscription = self.creator.subscriptions.not_expired.where('plan_id IN (?)', plans).includes(:plan).last
    if subscription
      self.users << user
      if subscription.plan.no_of_users < self.users.count
        self.project_users.find_by_user_id(user.id).update(additional_user: true, start_date: DateTime.now, end_date: DateTime.now + 1.months)
        subscription.update_column(:total_cost, subscription.plan.additional_user + subscription.total_cost)
      end
    end
  end

  private
  def add_owner_as_user
    user = self.creator.is_a?(Organization) ? self.creator.owner : self.creator
    self.users << user
  end

end
