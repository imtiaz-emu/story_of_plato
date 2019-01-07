class Plan < ApplicationRecord

  has_many :subscriptions, :dependent => :restrict_with_error

end
