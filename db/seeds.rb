# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
puts "Users destroyed"
Team.destroy_all
puts "Teams destroyed"
Member.destroy_all
puts "Members destroyed"
InitialQuestion.destroy_all
puts "InitialQuestions destroyed"
InitialAnswer.destroy_all
puts "InitialAnswers destroyed"
WeeklyQuestion.destroy_all
puts "WeeklyQuestions destroyed"
WeeklyAnswer.destroy_all
puts "WeeklyAnswers destroyed"

initial_question1 = InitialQuestion.create(content: "Where did you go to high school?")
initial_question2 = InitialQuestion.create(content: "What subject did you excel at most in your life?")
initial_question3 = InitialQuestion.create(content: "What is your favourite hobby?")
initial_question4 = InitialQuestion.create(content: "What is your favourite type of book?")
initial_question5 = InitialQuestion.create(content: "What do you think is the most important aspect for teamwork?")

user1 = User.create(email: 'user1@example.com', password: 'password')
user2 = User.create(email: 'user2@example.com', password: 'password')
puts "Created Users"

team1 = Team.create(name: 'Team 1', week_number: 1)
team2 = Team.create(name: 'Team 2', week_number: rand(1..3))
puts "Created Teams"

[user1, user2].each do |user|
  member = Member.create(user_id: user.id, weekly_points: 0, total_points: 0, team: team1)
  puts "Created Member for User #{user.email}"
end

20.times do |i|
  weekly_question = WeeklyQuestion.create!(content: "Sample question #{i+1}", team_id: 1)
  puts "Created WeeklyQuestion #{i+1}"

  [user1, user2].each do |user|
    correct_answer_index = rand(4)
    wrong_answers = (0..3).to_a - [correct_answer_index]

    weekly_answer = WeeklyAnswer.create(
      content: "Sample answer for question #{i+1}",
      user_id: user.id,
      correct_answer_index: correct_answer_index,
      wrong_answers: wrong_answers,
      weekly_question: weekly_question
    )

    puts "Created WeeklyAnswer for WeeklyQuestion #{i+1}"
  end
end

puts 'Database seeded!'
