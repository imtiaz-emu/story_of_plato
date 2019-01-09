class Task < ApplicationRecord

  belongs_to :card

  scope :completed, -> { where(completed: true) }

end
