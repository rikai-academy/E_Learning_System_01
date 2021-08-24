class Category < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :users, through: :wordlists
  before_create :default_status
  scope :search_name, lambda { |name|
    if name
      where("name like ?", "%#{name}%")
    else
      all
    end
  }
  scope :active, -> { where(status: true)}
  self.per_page = Settings.WillPaginate.cate_per_page
  validates :name, presence: true, length: {maximum: 50}
  validates :decription, presence: true, length: {minimum: 30}
  has_one_attached :image
  def self.search(name)
      categories = search_name name
      return categories unless categories.blank?
      all
  end
  def default_status
    self.status ||= true
  end
end
