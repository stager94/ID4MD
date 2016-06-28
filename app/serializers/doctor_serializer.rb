class DoctorSerializer < ActiveModel::Serializer
	attributes :id, :email, :availability, :speciality, :first_name, :last_name, :gender, :phone, :identifier

	def identifier
		object.id.to_s.rjust(5, "0")
	end
end
