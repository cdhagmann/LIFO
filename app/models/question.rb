# frozen_string_literal: true

class Question < ApplicationRecord
  include PgSearch
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_one :accepted_answer, foreign_key: 'question_accepted_id', class_name: 'Answer', dependent: :destroy
  pg_search_scope :search,
                  against: [:title],
                  using: {
                    tsearch: { dictionary: 'english' }
                  }

  def score
    votes.map { |vote| vote.value if vote.answer_id.nil? || 0 }.inject(:+) || 0
  end

  def has_accepted_answer?
    !!accepted_answer
  end
end
