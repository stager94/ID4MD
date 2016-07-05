AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Doctor.create email: "doctor@example.com", 
							first_name: "Наталия",
							last_name: "Мельникова",
							availability: 60,
							gender: "Женский",
							speciality: "Акушер-гинеколог / Врач УЗД",
							phone: "+380667593382", 
							password: "password"

Job.create doctor_id: Doctor.first.id,
					 name: "клиника «Будь Здоров!»",
					 address: "Москва, ул.Рябиновая, д.19"
Job.create doctor_id: Doctor.first.id,
					 name: "клиника «Мед-Си»",
					 address: "Москва, Ленинградский просп., д.28"
Job.create doctor_id: Doctor.first.id,
					 name: "городская поликлиника №41",
					 address: "Москва, ул.Ярцевская, д.2, корп.1"
