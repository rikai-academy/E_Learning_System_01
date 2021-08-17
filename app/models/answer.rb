class Answer < ApplicationRecord
  belongs_to :question
  scope :right_answer, -> { where(right_ans: true)}
  # Ex:- scope :active, -> {where(:active => true)}
end
