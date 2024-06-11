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

user1 = User.create(email: 'jack@example.com', password: 'password', username: "JackASS", description: "Cowboy in a puffer jacket")
file = URI.open("https://m.media-amazon.com/images/I/61ktJwNsInL._AC_SL1500_.jpghttps://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jphttps://m.media-amazon.com/images/I/61ktJwNsInL._AC_SL1500_.jpg")
user1.profile_image.attach(io: file, filename: "cowboy.png", content_type: "image/png")
user1.save

user2 = User.create(email: 'prince2@example.com', password: 'password', username: "Him Jong Un", description: "King")
puts "Created the Users"
file = URI.open("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfcMkNiLDXVaULaetBzC3xD2HDLaDRmvSKsw&sttps://www.google.com/url?sa=i&url=https%3A%2F%2Fstock.adobe.com%2Fsearch%2Fimages%3Fk%3D%2522black%2Bwolf%2522&psig=AOvVaw1492Z1jzi2Y0sHeiaEFDgf&ust=1717854811894000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKjYw4HSyYYDFQAAAAAdAAAAABAE")
user2.profile_image.attach(io: file, filename: "wolf.png", content_type: "image/png")
user2.save

user3 = User.create(email: 'thomass2@example.com', password: 'password', username: "ThomASS", description: "greatest human to ever live")
puts "Created the Users"
file = URI.open("https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Cima_da_Conegliano%2C_God_the_Father.jpg/640px-Cima_da_Conegliano%2C_God_the_Father.jpg")
user3.profile_image.attach(io: file, filename: "god.png", content_type: "image/png")
user3.save

team1 = Team.create(name: 'Le Wagon', week_number: 1)
team2 = Team.create(name: 'BreakerBoys', week_number: rand(1..3))
puts "Created #{Team.count} Teams"

member1 = Member.create(user: user1, weekly_points: 0, total_points: 0, team: team1)
member1 = Member.create(user: user1, weekly_points: 0, total_points: 0, team: team2)
member2 = Member.create(user: user2, weekly_points: 0, total_points: 0, team: team1)
puts "Created #{Member.count} Members"

weekly_question1 = WeeklyQuestion.create!(content: "If you could have any superpower, what would it be?", team_id: team1.id)
weekly_question2 = WeeklyQuestion.create!(content: "What's your favorite travel destination", team_id: team1.id)
weekly_question3 = WeeklyQuestion.create!(content: "If you could meet any historical figure, who would it be?", team_id: team1.id)
puts "Created #{WeeklyQuestion.count} Weeklies"

super_powers = [
  "Telekinesis",
  "Invisibility",
  "Superhuman strength",
  "Flight",
  "Time manipulation",
  "Teleportation",
  "Mind reading",
  "Shape-shifting",
  "Energy manipulation",
  "Healing factor"
]

travel_destinations = [
  "Paris",
  "Tokyo",
  "New York City",
  "Santorini",
  "Machu Picchu",
  "Sydney",
  "Rio de Janeiro",
  "Cape Town",
  "Kyoto",
  "Venice"
]

historical_figures = [
  "Leonardo da Vinci",
  "Cleopatra",
  "Nelson Mandela",
  "Queen Elizabeth I",
  "Albert Einstein",
  "Mahatma Gandhi",
  "Joan of Arc",
  "Winston Churchill",
  "Marie Curie",
  "Genghis Khan"
]

school_names = [
  "Maplewood High School",
  "Riverside Academy",
  "Oakmont Preparatory School",
  "Crescent Valley Elementary",
  "Greenfield Middle School",
  "Willowbrook Elementary",
  "Sunset Ridge High School",
  "Pinecrest Academy",
  "Harmony Hills School",
  "Briarwood Elementary"
]

school_subjects = [
  "Mathematics",
  "English Language Arts",
  "Science",
  "History",
  "Physical Education",
  "Art",
  "Music",
  "Computer Science",
  "Foreign Language",
  "Social Studies"
]

hobbies = [
  "Reading",
  "Painting",
  "Hiking",
  "Cooking",
  "Playing musical instruments",
  "Photography",
  "Gardening",
  "Writing",
  "Dancing",
  "Knitting/Crocheting"
]

teamwork_aspects = [
  "Communication",
  "Collaboration",
  "Trust",
  "Respect",
  "Responsibility",
  "Adaptability",
  "Leadership",
  "Problem-solving",
  "Feedback",
  "Goal setting"
]

books = [
  "Catcher in the Rye",
  "48 Laws of Power",
  "Harry Potter Series",
  "To Kill a Mockingbird",
  "1984",
  "Pride and Prejudice",
  "The Great Gatsby",
  "Moby Dick",
  "The Hobbit",
  "Brave New World",
  "The Alchemist",
  "The Lord of the Rings"
]

User.all.each do |user|

  # initial question 1
  initial_answer = InitialAnswer.create(
    content: school_names.sample,
    user: user,
    wrong_answers: "#{school_names.sample}, #{school_names.sample}, #{school_names.sample}",
    initial_question: initial_question1
  )

  # initial question 2
  initial_answer = InitialAnswer.create(
    content: school_subjects.sample,
    user: user,
    wrong_answers: "#{school_subjects.sample}, #{school_subjects.sample}, #{school_subjects.sample}",
    initial_question: initial_question2
  )

  # initial question 3
  initial_answer = InitialAnswer.create(
    content: hobbies.sample,
    user: user,
    wrong_answers: "#{hobbies.sample}, #{hobbies.sample}, #{hobbies.sample}",
    initial_question: initial_question3
  )

  # initial question 4
  initial_answer = InitialAnswer.create(
    content: books.sample,
    user: user,
    wrong_answers: "#{books.sample}, #{books.sample}, #{books.sample}",
    initial_question: initial_question4
  )

  # initial question 5
  initial_answer = InitialAnswer.create(
    content: teamwork_aspects.sample,
    user: user,
    wrong_answers: "#{teamwork_aspects.sample}, #{teamwork_aspects.sample}, #{teamwork_aspects.sample}",
    initial_question: initial_question5
  )

  # weekly question 1
  weekly_answer = WeeklyAnswer.create(
    content: super_powers.sample,
    user: user,
    wrong_answers: "#{super_powers.sample}, #{super_powers.sample}, #{super_powers.sample}",
    weekly_question: weekly_question1
  )

  # weekly question 2
  weekly_answer = WeeklyAnswer.create(
    content: travel_destinations.sample,
    user: user,
    wrong_answers: "#{travel_destinations.sample}, #{travel_destinations.sample}, #{travel_destinations.sample}",
    weekly_question: weekly_question2
  )

  # weekly question 3
  weekly_answer = WeeklyAnswer.create(
    content: historical_figures.sample,
    user: user,
    wrong_answers: "#{historical_figures.sample}, #{historical_figures.sample}, #{historical_figures.sample}",
    weekly_question: weekly_question3
  )
end

puts 'Database seeded!'
