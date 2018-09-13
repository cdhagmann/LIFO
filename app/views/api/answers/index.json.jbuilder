json.array! @answers do |answer|
  json.extract! answer, :id, :body 
  json.accepted answer.accepted?
  json.username answer.user.username
  json.score    answer.score
end