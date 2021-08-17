class ContentLesson < ApplicationRecord
  validates :word, presence: :true, uniqueness: true
  validates :mean, presence: :true, uniqueness: true
  belongs_to :lesson
end
