json.array! @questions do |question|
  json.extract! question, :id, :body 
  json.answers question.answers.count
  json.username question.user.username
end