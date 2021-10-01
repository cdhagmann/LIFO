# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  # validates :question_accepted_id, uniqueness: true
  has_many :votes, dependent: :destroy

  def score
    votes.map(&:value).inject(:+) || 0
  end

  def accepted?
    !!question_accepted_id
  end
end
