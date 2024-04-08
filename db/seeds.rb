# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([{name: "はぎわら", phone_number: "090-1234-5678"}, {name: "たけち", phone_number: "090-1234-5678"}, {name: "たけだ", phone_number: "090-1234-5678"}])
staffs = Staff.create([{staff_id: "10001", name: "もも"}, {staff_id: "10002", name: "みつき"}, {staff_id: "10003", name: "つらら"}])
schedule = staffs[0].create_schedule("2023-01-01 11:00:00", "2023-01-01 17:00:00")
schedule.create_reservation(DateTime.parse("2023-01-01 11:00:00"), 80.minutes)
schedule.create_reservation(DateTime.parse("2023-01-01 13:00:00"), 80.minutes)
schedule.create_reservation(DateTime.parse("2023-01-01 14:20:00"), 100.minutes)
staffs[0].create_schedule("2023-01-02 13:00:00", "2023-01-02 19:00:00")

staffs[1].create_schedule("2023-01-01 13:00:00", "2023-01-01 19:00:00")
staffs[1].create_schedule("2023-01-02 13:00:00", "2023-01-02 19:00:00")

staff_2_schedule = staffs[2].create_schedule("2023-01-01 14:00:00", "2023-01-01 20:00:00")
staff_2_schedule.create_reservation(DateTime.parse("2023-01-01 15:30:00"), 30.minutes)
staff_2_schedule.create_reservation(DateTime.parse("2023-01-01 17:30:00"), 70.minutes)
