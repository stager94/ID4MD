namespace :doctors do
	task create_first: :environment do
		Doctor.create email: "stager@example.com", password: "password"
	end
end
