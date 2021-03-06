class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  # Associations
  has_many :organizations, foreign_key: :created_by, dependent: :destroy
  has_and_belongs_to_many :organizations
  has_many :subscriptions, as: :plan_subscriber
  has_many :projects, as: :creator
  has_many :project_users
  has_many :projects, through: :project_users


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
    end
  end

end
