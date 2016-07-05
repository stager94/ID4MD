# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Doctor.create email: "doctor@example.com", 
							first_name: "Наталия",
							last_name: "Мельникова",
							availability: 60,
							gender: "Женский",
							speciality: "Акушер-гинеколог / Врач УЗД",
							phone: "+380667593382", 
							password: "password"
