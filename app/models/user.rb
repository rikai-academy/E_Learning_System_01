class User < ApplicationRecord
  self.per_page = Settings.WillPaginate.user_per_page
  has_many :summaries, dependent: :destroy
  has_many :wordlists, dependent: :destroy
  has_many :categories, through: :wordlists
  scope :activities,
    -> (user_array) {select(:username, :"categories.name", :"wordlists.created_at").joins(:categories).where("user_id in (?) ", user_array).order("wordlists.created_at": :desc)}
  validates :username, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, 
                          format: { with: VALID_EMAIL_REGEX }, 
                          uniqueness: true
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                          foreign_key: "followed_id",
                          dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  def self.get_activites user_array
    if user_array
      activities user_array
    end
  end
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(id_user)
    other_user = User.find(id_user)
    following.include?(other_user)
  end
  
  def User.digest(string)
    if ActiveModel::SecurePassword.min_cost
      cost = BCrypt::Engine::MIN_COST
    else
      cost = BCrypt::Engine.cost
    end
    BCrypt::Password.create(string, cost: cost)
  end
end
