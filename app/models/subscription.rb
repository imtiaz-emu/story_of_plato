class Subscription < ApplicationRecord

  belongs_to :plan_subscriber, polymorphic: true
  belongs_to :plan

end
