json.array! @questions do |question|
  json.extract! question, :id, :body 
  json.score question.score
  json.answers question.answers.count
  json.username question.user.username
end