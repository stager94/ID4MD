namespace :doctors do
	task create_first: :environment do
		Doctor.create email: "doctor@example.com", 
									first_name: "Наталия",
									last_name: "Мельникова",
									availability: 60,
									gender: "Мужской",
									speciality: "Акушер-гинеколог / Врач УЗД",
									phone: "+380667593382", 
									password: "password"
	end
end
