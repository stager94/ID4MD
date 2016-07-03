namespace :patients do
	task create_first: :environment do
		Patient.create email: "patient@example.com", password: "password"
	end
end
