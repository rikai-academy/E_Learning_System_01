class Category < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}
  validates :decription, presence: true, length: {minimum: 30}
end
