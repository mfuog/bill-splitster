# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#
# Users
#

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

#
# Bill sheets
#

sheet1 = BillSheet.create!(
  creator: alice,
  title: "Birthday party for John",
  description: "here we're collecting what everyone spent for John's surprise birthday party.",
  status: "open"
)

sheet2 = BillSheet.create!(
  creator: bob,
  title: "Lapland trip",
  description: "Let's collect all of our spendings of the week here!.",
  status: "open"
)

#
# Participants
#

aris = Participant.create!(
  bill_sheet: sheet1,
  name: "Aris",
)

alex = Participant.create!(
  bill_sheet: sheet1,
  name: "Alex",
)

steve = Participant.create!(
  bill_sheet: sheet1,
  name: "Steve",
)

judith = Participant.create!(
  bill_sheet: sheet2,
  name: "Judith",
)

marcel = Participant.create!(
  bill_sheet: sheet2,
  name: "Marcel",
)

nico = Participant.create!(
  bill_sheet: sheet2,
  name: "Nico",
)

lin = Participant.create!(
  bill_sheet: sheet2,
  name: "Lin",
)

#
# Bills
#

Bill.create!(
  participant: nico,
  amount: 12.5,
  title: "grocery",
  note: "at Willy's"
)

Bill.create!(
  participant: lin,
  amount: 40.0,
  title: "tickets museum",
  note: ""
)

Bill.create!(
  participant: aris,
  amount: 87.5,
  title: "train tickets",
  note: ""
)

Bill.create!(
  participant: nico,
  amount: 52.5,
  title: "grocery",
  note: ""
)

Bill.create!(
  participant: judith,
  amount: 125.0, 
  title: "restaurant",
  note: "shushi bar downtown"
)

Bill.create!(
  participant: steve,
  amount: 45.0,
  title: "museum of modern art",
  note: ""
)