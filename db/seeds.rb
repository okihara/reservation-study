# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([{name: "はぎわら", phone_number: "090-1234-5678"}, {name: "たけち", phone_number: "090-1234-5678"}, {name: "たけだ", phone_number: "090-1234-5678"}])
staffs = Staff.create([{name: "もも"}, {name: "みつき"}, {name: "つらら"}])
schedule = staffs[0].create_schedule("2023-01-01 11:00:00", "2023-01-01 17:00:00")
schedule.create_reservation(DateTime.parse("2023-01-01 11:00:00"), 80.minutes)
schedule.create_reservation(DateTime.parse("2023-01-01 13:00:00"), 80.minutes)
staffs[0].create_schedule("2023-01-02 13:00:00", "2023-01-02 19:00:00")

staffs[1].create_schedule("2023-01-02 13:00:00", "2023-01-02 19:00:00")