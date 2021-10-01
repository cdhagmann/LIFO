# frozen_string_literal: true

json.data do
  json.type 'questions'
  json.id question.id
  json.attributes do
    json.user_id question.user_id
    json.body question.body
    json.questioned_at question.created_at
  end
  json.relationships do
    json.user do
      json.data do
        json.id question.user.id
        json.username question.user.username
      end
      json.links do
        json.self api_user_url(question.user)
      end
    end
  end
  json.links do
    json.self api_question_url(question.user, question)
    json.list api_questions_url(question.user)
    if question.user.id == current_user.id
      json.delete do
        json.method 'DELETE'
        json.href api_user_question_url(question.user, question)
      end
    end
  end
end
