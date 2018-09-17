json.links do
  json.self api_user_question_url(@question.user.id, @question.id)
  json.list api_user_questions_url(@question.user.id)
  json.delete do
    json.method "DELETE"
    json.href api_user_question_url(@question.user.id, @question.id)
  end
end
json.data do
  json.user_id @question.user_id
  json.username @question.user.username
  json.attributes do
    json.id @question.id
    json.body @question.body
    json.answers_count @question.answers.count
    json.accepted_answer @question.has_accepted_answer?
  end
end