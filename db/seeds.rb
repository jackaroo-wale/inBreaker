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
puts "User destroyed"
Team.destroy_all
puts "Team destroyed"
Member.destroy_all
puts "Member destroyed"
InitialQuestion.destroy_all
puts "IQ destroyed"
InitialAnswer.destroy_all
puts "IA destroyed"
WeeklyQuestion.destroy_all
puts "WQ destroyed"
WeeklyAnswer.destroy_all
puts "WA destroyed"

initial_question1 = InitialQuestion.create(content: "Where did you go to high school?")
initial_question2 = InitialQuestion.create(content: "What subject did you excel at most in your life?")
initial_question3 = InitialQuestion.create(content: "What is your favourite hobby?")
initial_question4 = InitialQuestion.create(content: "What is your favourite type of book?")
initial_question5 = InitialQuestion.create(content: "What do you think is the most important aspect for teamwork?")

user1 = User.create(email: 'user1@example.com', password: 'password')
user2 = User.create(email: 'user2@example.com', password: 'password')
puts "Created the Users"

member1 = Member.create(user: user1, weekly_points: 0, total_points: 0)
member2 = Member.create(user: user2, weekly_points: 0, total_points: 0)
puts "Created the Members"

team1 = Team.create(name: 'Team 1', week_number: 1)
team2 = Team.create(name: 'Team 2', week_number: rand(1..3))
puts "Created the Team"

20.times do |i|
  weekly_question = WeeklyQuestion.create!(content: "Sample question #{i+1}")
  puts "Created the Weekly"

  User.all.each do |user|
    correct_answer_index = rand(4)
    puts "fine"
    wrong_answers = (0..3).to_a - [correct_answer_index]

    weekly_answer = WeeklyAnswer.create(
      content: "Sample answer for question #{i+1}",
      user: user,
      correct_answer_index: correct_answer_index,
      wrong_answers: wrong_answers
    )

    puts "really"
    weekly_answer.update(weekly_question_id: weekly_question.id)
    puts "not really"
  end
end





puts 'Database seeded!'
