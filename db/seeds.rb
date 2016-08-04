# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create name: "admin",
  email: "admin@gmail.com",
  password: "1",
  password_confirmation: "1",
  role: 2
user = User.create name: "trainee",
  email: "trainee@gmail.com",
  password: "1",
  password_confirmation: "1",
  role: 0
supervisor = User.create name: "super",
  email: "super@gmail.com",
  password: "1",
  password_confirmation: "1",
  role: 1

10.times do |s|
  title = Faker::Name.name
  description = Faker::Lorem.sentence
  Subject.create! title: title, description: description,
  tasks_attributes: [
    {title:"Lesson 1", description: "lesson 1"},
    {title:"Lesson 2", description: "lesson 2"},
    {title:"Lesson 3", description: "lesson 3"},
    {title:"Lesson 4", description: "lesson 4"}]
end

Course.create! title: "Web Development", description: "How to make a web app",
  subject_ids: ["1","2"]
Course.create! title: "App Development", description: "Flappy",
  subject_ids: ["4","7"]
