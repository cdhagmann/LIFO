# frozen_string_literal: true

json.array! @questions do |question|
  json.extract! question, :id, :title, :body
  json.score question.vote_count
  json.answers question.answer_count
  json.accepted_answer question.accepted
  json.username question.username
end
