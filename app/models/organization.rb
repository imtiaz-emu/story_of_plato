class Organization < ApplicationRecord

  belongs_to :owner, foreign_key: :created_by, class_name: 'User'
  has_and_belongs_to_many :users
  has_many :subscriptions, as: :plan_subscriber

  scope :owned_organizations, ->(user_id) { where('created_by = (?)', user_id) }

end
