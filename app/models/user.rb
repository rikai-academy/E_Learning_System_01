class User < ApplicationRecord
  has_one :user_profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable , omniauth_providers: [:facebook, :google_oauth2]
  validates :username, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, 
                          format: { with: VALID_EMAIL_REGEX }, 
                          uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  def User.digest(string)
    if ActiveModel::SecurePassword.min_cost
      cost = BCrypt::Engine::MIN_COST
    else
      cost = BCrypt::Engine.cost
    end
    BCrypt::Password.create(string, cost: cost)
  end
  def self.from_omniauth(auth)
    result = User.where(email: auth.info.email).first
    if result
      result.user_profile.image.attach(auth.info.image)
      return result
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.fullname = auth.info.name
        user.user_profile.image.attach(auth.info.image)
        user.uid = auth.uid
        user.provider = auth.provider

        #  If you are using confirmable and the provider(s) you use validate emails
        user.skip_confirmation!
      end
    end
  end
end
