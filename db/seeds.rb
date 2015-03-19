# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

me = User.create!(
	name: ENV["MY_NAME"],
	email: ENV["MY_EMAIL"],
	password: ENV["MY_PASSWORD"],
	password_confirmation: ENV["MY_PASSWORD"],
)
alice = User.create!(
  name: "Alice",
  email: "alice@example.com",
  password: "alice",
  password_confirmation: "alice"
)
bob = User.create!(
  name: "Bob",
  email: "bob@example.com",
  password: "bob",
  password_confirmation: "bob"
)