class Plan < ApplicationRecord

  has_many :subscriptions, :dependent => :restrict_with_error

  scope :active, -> { where('active = (?)', true) }
  scope :inactive, -> { where('active = (?)', false) }
  scope :other_than_solo, -> { where("plan_type IN (?)", ['startup', 'enterprise', 'business'])}

end
