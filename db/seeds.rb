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
Member.destroy_all
Team.destroy_all
InitialQuestion.destroy_all
InitialAnswer.destroy_all
WeeklyQuestion.destroy_all
WeeklyAnswer.destroy_all

user1 = User.create(email: 'user1@example.com', password: 'password')
user2 = User.create(email: 'user2@example.com', password: 'password')

member1 = Member.create(user: user1, weekly_points: 0, total_points: 0)
member2 = Member.create(user: user2, weekly_points: 0, total_points: 0)

team1 = Team.create(name: 'Team 1', member: member1)
team2 = Team.create(name: 'Team 2', member: member2)

initial_question1 = InitialQuestion.create(content: 'What is the capital of France?')
initial_question2 = InitialQuestion.create(content: 'What is 2 + 2?')

initial_answer1 = InitialAnswer.create(content: 'Paris', user: user1, initial_question: initial_question1, wrong_answers: 0)
initial_answer2 = InitialAnswer.create(content: '4', user: user2, initial_question: initial_question2, wrong_answers: 0)

weekly_question1 = WeeklyQuestion.create(content: 'What is the capital of Spain?', week_number: 1)
weekly_question2 = WeeklyQuestion.create(content: 'What is 3 + 3?', week_number: 1)

team1.update(weekly_question: weekly_question1)
team2.update(weekly_question: weekly_question2)

weekly_answer1 = WeeklyAnswer.create(content: 'Madrid', user: user1, weekly_question: weekly_question1, wrong_answers: 0)
weekly_answer2 = WeeklyAnswer.create(content: '6', user: user2, weekly_question: weekly_question2, wrong_answers: 0)

puts 'Database seeded!'
