class DoctorSerializer < ActiveModel::Serializer
	attributes :id, :email, :availability, :speciality, :first_name, 
						 :last_name, :gender, :phone, :identifier, :name, :work_times, :jobs

	def jobs
		object.jobs.map { |job| JobSerializer.new(job) }
	end

	def identifier
		object.id.to_s.rjust(5, "0")
	end

	def work_times
		[
			{
				title: "пн-пт",
				time_range: "9:00-19:00"
			},
			{
				title: "сб",
				time_range: "10:00-15:00"
			}
		]
	end

end
