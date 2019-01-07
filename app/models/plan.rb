class Plan < ApplicationRecord

  has_many :subscriptions, :dependent => :restrict_with_error

  scope :active, -> { where('active = (?)', true) }
  scope :inactive, -> { where('active = (?)', false) }

end
