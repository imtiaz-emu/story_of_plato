class Project < ApplicationRecord

  belongs_to :creator, polymorphic: true
  has_many  :subscriptions
  has_many :project_users
  has_many :users, through: :project_users


  after_create :add_owner_as_user


  private
  def add_owner_as_user
    user = self.creator.is_a?(Organization) ? self.creator.owner : self.creator
    self.users << user
  end

end
