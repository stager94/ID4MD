namespace :doctors do
	task create_first: :environment do
		Doctor.create email: "doctor@example.com", password: "password"
	end
end
