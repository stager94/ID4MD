namespace :patients do
	task create_first: :environment do
		Patient.create email: "stager@example.com", password: "password"
	end
end
