class Organization < ApplicationRecord

  belongs_to :owner, foreign_key: :created_by, class_name: 'User'

end
