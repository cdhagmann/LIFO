# frozen_string_literal: true

json.links do
  json.self api_user_url(user)
end
json.data do
  json.id user.id
  json.attributes do
    json.username user.username
    json.email user.email
    json.question user.questions.count
  end
  json.relationships do
    json.questions do
      json.array! user.questions do |question|
        json.data question, :id, :body
        json.links do
          json.self api_user_question_path(user, question)
        end
      end
    end
  end
end
