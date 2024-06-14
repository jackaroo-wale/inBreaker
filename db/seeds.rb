require 'open-uri'

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

user1 = User.create(email: 'jack3@example.com', password: 'password', username: "Jack", description: "Learning to code")
file = URI.open("https://avatars.githubusercontent.com/u/166990332?v=4")
user1.profile_image.attach(io: file, filename: "cowboy.png", content_type: "image/png")
user1.save

user2 = User.create(email: 'prince3@example.com', password: 'password', username: "Prince", description: "A wolf in disguise as a man")
file = URI.open("https://avatars.githubusercontent.com/u/75453290?v=4")
user2.profile_image.attach(io: file, filename: "wolfnotman.png", content_type: "image/png")
user2.save

user3 = User.create(email: 'thomas3@example.com', password: 'password', username: "Thomas", description: "Greatest human to ever live")
file = URI.open("https://avatars.githubusercontent.com/u/162109209?v=4")
user3.profile_image.attach(io: file, filename: "thomas.png", content_type: "image/png")
user3.save

user4 = User.create(email: 'meg@example.com', password: 'password', username: "Meg", description: "Loving this game!")
file = URI.open("https://avatars.githubusercontent.com/u/82448006?v=4")
user4.profile_image.attach(io: file, filename: "meg.png", content_type: "image/png")
user4.save

user5 = User.create(email: 'luvo@example.com', password: 'password', username: "Luvo", description: "Seize the day and
  create the change you want to follow")
file = URI.open("https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1713491298/d2e0wbixvrozx8xfaoxu.jpg")
user5.profile_image.attach(io: file, filename: "Luvo.png", content_type: "image/png")
user5.save

user6 = User.create(email: 'nolu@example.com', password: 'password', username: "Nolu", description: "yes!")
file = URI.open("https://avatars.githubusercontent.com/u/82448006?v=4")
user6.profile_image.attach(io: file, filename: "nolu.png", content_type: "image/png")
user6.save

team1 = Team.create(name: "Le Wagon batch #1676", week_number: 1)
puts "Created #{Team.count} Teams"
file1 = URI.open("https://avatars.githubusercontent.com/u/5470001?s=280&v=4")
team1.team_image.attach(io: file1, filename: "lewagon.png", content_type: "image/png")
team1.save

team2 = Team.create(name: "Phriday Photography Group", week_number: rand(1..3))
puts "Created #{Team.count} Teams"
file2 = URI.open("https://images.pexels.com/photos/1208074/pexels-photo-1208074.jpeg?cs=srgb&dl=pexels-cody-king-433493-1208074.jpg&fm=jpg")
team2.team_image.attach(io: file2, filename: "lens.png", content_type: "image/png")
team2.save

team3 = Team.create(name: "Slaves to the Waves", week_number: rand(1..3))
puts "Created #{Team.count} Teams"
file3 = URI.open("https://assets.simpleviewinc.com/simpleview/image/upload/c_fill,f_webp,h_500,q_55,w_1170/v1/clients/visitflorida/GayBeach1_ec2e376a-8b54-45e8-bd10-a649f0909bec.jpg")
team3.team_image.attach(io: file3, filename: "paddleboet.png", content_type: "image/png")
team3.save

team4 = Team.create(name: "Saturday Padel Team", week_number: rand(1..3))
puts "Created #{Team.count} Teams"
file4 = URI.open("https://media.istockphoto.com/id/1381923192/vector/vintage-paddle-tennis-logo-icon-vector-on-white-background.jpg?s=612x612&w=0&k=20&c=NGw6Yb7jcC88fkn7vhd9wr95vhS44vxxlJg8rF1lW6k=")
team4.team_image.attach(io: file4, filename: "padel.png", content_type: "image/png")
team4.save

# team_default_image = URI.open("https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg")


# team4 = Team.create(name: "Le Wagon batch #1676", week_number: rand(1..4))
# puts "Created #{Team.count} Teams"
# file4 = URI.open("https://avatars.githubusercontent.com/u/5470001?s=280&v=4")
# team4.team_image.attach(io: file4, filename: "lewagon.png", content_type: "image/png")
# team4.save

member1 = Member.create(user: user1, weekly_points: 0, total_points: 0, team: team1)
member1 = Member.create(user: user1, weekly_points: 0, total_points: 0, team: team2)
member2 = Member.create(user: user2, weekly_points: 0, total_points: 0, team: team1)
member1 = Member.create(user: user1, weekly_points: 0, total_points: 0, team: team3)
member3 = Member.create(user: user3, weekly_points: 0, total_points: 0, team: team1)
member4 = Member.create(user: user4, weekly_points: 0, total_points: 0, team: team1)
member5 = Member.create(user: user5, weekly_points: 0, total_points: 0, team: team1)
member6 = Member.create(user: user6, weekly_points: 0, total_points: 0, team: team1)
member5 = Member.create(user: user5, weekly_points: 0, total_points: 80, team: team2)
member6 = Member.create(user: user6, weekly_points: 0, total_points: 104, team: team2)

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
  "Healing factor",
  "Pyrokinesis",
  "Cryokinesis",
  "X-ray vision",
  "Super speed",
  "Elasticity",
  "Force field generation",
  "Electrokinesis",
  "Magnetism manipulation",
  "Animal communication",
  "Intangibility",
  "Precognition",
  "Density control",
  "Size manipulation",
  "Duplication",
  "Regeneration",
  "Laser vision",
  "Telepathy",
  "Technopathy",
  "Bioluminescence",
  "Infravision",
  "Hydrokinesis",
  "Aerokinesis",
  "Chronokinesis",
  "Gravity manipulation",
  "Phasing",
  "Probability manipulation",
  "Heat vision",
  "Plant manipulation",
  "Sound manipulation",
  "Clairvoyance",
  "Teleportation",
  "Summoning",
  "Hypnosis",
  "Force manipulation",
  "Necromancy",
  "Dimensional travel",
  "Transmutation",
  "Sonic scream",
  "Illusion casting",
  "Mental projection"
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
  InitialAnswer.create(content: school_names.sample, user: user, wrong_answers: "#{school_names.sample}, #{school_names.sample}, #{school_names.sample}", initial_question: initial_question1)
  InitialAnswer.create(content: school_subjects.sample, user: user, wrong_answers: "#{school_subjects.sample}, #{school_subjects.sample}, #{school_subjects.sample}", initial_question: initial_question2)
  WeeklyAnswer.create(content: super_powers.sample, user: user, wrong_answers: "#{super_powers.sample}, #{super_powers.sample}, #{super_powers.sample}", weekly_question: weekly_question1)
end

chatroom1 = Chatroom.create(name: team1.name, team: team1)

Message.create(content: 'I am the best', user: user1, chatroom: chatroom1)
Message.create(content: 'No, I am number 1, the best. BEST', user: user2, chatroom: chatroom1)
Message.create(content: 'Say less', user: user3, chatroom: chatroom1)
Message.create(content: 'Prince just joined', user: user1, chatroom: chatroom1)

puts 'Database seeded!'
