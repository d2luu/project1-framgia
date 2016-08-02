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
