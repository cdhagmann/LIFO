json.links do
  json.self api_user_url(@user)
  json.list api_users_url
  json.update do
    json.method "PUT"
    json.href api_user_url(@user)
  end
  json.delete do
    json.method "DELETE"
    json.href api_user_url(@user)
  end
end
json.data do
  json.id @user.id
  json.attributes do
    json.username @user.username
    json.api_token @user.api_token
    json.questions @user.questions.count
    json.answers @user.answers.count
  end
end