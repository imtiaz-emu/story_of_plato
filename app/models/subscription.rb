class Subscription < ApplicationRecord

  attr_accessor :duration_type

  belongs_to :plan_subscriber, polymorphic: true
  belongs_to :plan

end
