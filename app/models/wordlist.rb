class Wordlist < ApplicationRecord
  belongs_to :user
  scope :found_category, -> wordlist { where("category_id = ? and user_id = ?", wordlist[:category_id], wordlist[:user_id])}
  belongs_to :category
  def self.found_dup category_id, user_id
    if category_id && user_id
      wordlist = {}
      wordlist[:category_id] = category_id
      wordlist[:user_id] = user_id
      found_category wordlist
    end
  end
end
