class DoctorSerializer < ActiveModel::Serializer
	attributes :id, :email, :availability, :speciality, :first_name, 
						 :last_name, :gender, :phone, :identifier, :name,
						 :jobs, :work_times

	def identifier
		object.id.to_s.rjust(5, "0")
	end

	def jobs
		[
			{
				address: "Москва, ул.Рябиновая, д.19, клиника «Будь Здоров!»"
			},
			{
				address: "Москва, Ленинградский просп., д.28, клиника «Мед-Си»"
			},
			{
				address: "Москва, ул.Ярцевская, д.2, корп.1, городская поликлиника №41."
			}
		]
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
