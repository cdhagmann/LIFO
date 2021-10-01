# frozen_string_literal: true

json.links do
  json.self api_question_url(@question)
  json.list api_questions_url
  if @question.user_id == token_user.id
    json.delete do
      json.method 'DELETE'
      json.href api_question_url(@question)
    end
  end
end
json.data do
  json.user_id @question.user_id
  json.username @question.user.username
  json.attributes do
    json.id @question.id
    json.title @question.title
    json.body @question.body
    json.score @question.score
    json.answers @question.answers.count
    json.accepted_answer @question.has_accepted_answer?
  end
  json.relationships do
    json.answers do
      json.array! @question.answers do |answer|
        json.data answer, :id, :body
        json.score answer.score
        json.accepted answer.accepted?
        json.links do
          json.self api_question_answer_path(@question, answer)
        end
      end
    end
  end
end
