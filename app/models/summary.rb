class Summary < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  scope :suma, -> { where(status: true)}
  # Ex:- scope :active, -> {where(:active => true)}
  validates :content, presence: :true
  belongs_to :user
end
