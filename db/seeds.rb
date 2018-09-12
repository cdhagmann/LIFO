# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.new
user.username = 'admin'
user.email = 'admin@lifo.com'
user.password = "admin"
user.save
directory = "./sailor_pictures/"
filename = Dir.glob("*.jpg", base: directory).sample
user.avatar.attach(io: File.open(File.join(directory, filename)), filename: filename)


49.times do
  @user = User.create!(
  username: Faker::Internet.unique.username,
  email: 'cdhagmann+lifo@gmail.com',
  password: "user"
  )
  @directory = "./sailor_pictures/"
  @filename = Dir.glob("*.jpg", base: @directory).sample
  @user.avatar.attach(io: File.open(File.join(@directory, @filename)), filename: @filename)
end

250.times do
  Question.create!(
    title: Faker::Lorem.sentence, 
    body: (Faker::Markdown.sandwich(6, 3) + '<br/>' + Faker::Markdown.inline_code + '<br/>' + Faker::Markdown.sandwich(6, 3)),
    user_id: 1 + rand(50)
  )
end

500.times do
  Answer.create(
    user_id: 1 + rand(50), 
    question_id: 1 + rand(250),
    body: (Faker::Markdown.sandwich(6, 3) + '<br/>' + Faker::Markdown.inline_code + '<br/> ' + Faker::Markdown.sandwich(6, 3)),
  )
end


Question.all.each do |question|
  if (question.answers.any? && rand() > 0.4)
    answer = question.answers.sample
    question_id = question.id
    answer.update({question_accepted_id: question_id})
  end
end

1500.times do
  Vote.create(
    value: [-1,1].sample,
    user_id: 1 + rand(50), 
    answer_id: 1 + rand(500)
  )
end