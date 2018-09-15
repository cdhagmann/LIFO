json.links do
  json.self api_question_url(@question.user.id, @question.id)
  json.list api_questions_url(@question.user.id)
  json.delete do
    json.method "DELETE"
    json.href api_question_url(@question.user.id, @question.id)
  end
end
json.data do
  json.user_id @question.user_id
  json.username @question.user.username
  json.attributes do
    json.id @question.id
    json.body @question.body
  end
  json.relationships do
    json.answers do
      json.array! @question.answers do |answer|
        json.data answer, :id, :body
        json.links do
          json.self api_question_answer_path(@question, answer)
        end
      end
    end
  end
end