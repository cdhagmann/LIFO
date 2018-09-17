json.links do
  json.self api_question_answer_url(@question, @answer)
  json.list api_question_answers_url(@question)
  if token_user.id == @answer.user.id
    json.delete do
      json.method "DELETE"
      json.href api_question_answer_url(@question, @answer)
    end
  end
end
json.data do
  json.user_id @answer.user_id
  json.username @answer.user.username
  json.attributes do
    json.id @answer.id
    json.body @answer.body
    json.accepted @answer.accepted?
    json.score @answer.score
  end
end