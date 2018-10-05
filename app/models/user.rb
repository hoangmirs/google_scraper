class User < ApplicationRecord
  has_many :search_results, dependent: :destroy
  has_many :access_grants, class_name: "Doorkeeper::AccessGrant",
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  class << self
    def from_omniauth auth_hash
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.email = auth_hash['info']['email']
      user.password = Devise.friendly_token[0,20]
      user.save!
      user
    end
  end
end
