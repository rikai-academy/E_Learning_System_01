class Summary < ApplicationRecord
  scope :summary_active, -> { where(status: true).order(created_at: :desc) }
  validates :content, presence: :true
  belongs_to :user
end
