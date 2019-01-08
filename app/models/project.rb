class Project < ApplicationRecord

  belongs_to :creator, polymorphic: true
  has_many  :subscriptions

end
