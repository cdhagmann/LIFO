class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :answer, optional: true
  belongs_to :question, optional: true
end
