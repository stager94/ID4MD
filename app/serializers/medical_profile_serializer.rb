class MedicalProfileSerializer < ActiveModel::Serializer
	attributes :id, :diagnosis, :appointments_count, :diagnosises_count, :visits_count

	belongs_to :doctor, serializer: DoctorSerializer

	def appointments_count
		object.appointments.following.count
	end

	def visits_count
		object.visits.following.count
	end

	def diagnosises_count
		object.diagnosises.following.count
	end	
end
