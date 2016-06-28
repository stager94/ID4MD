class DoctorSerializer < ActiveModel::Serializer
	attributes :id, :email, :availability, :availability_human

	def availability_human
		case object.availability
		when 60
			"1 часа"
		when 120
			"2 часов"
		when 180
			"3 часов"
		when 1440
			"1 дня"
		else
			"undefined"
		end
	end
end
