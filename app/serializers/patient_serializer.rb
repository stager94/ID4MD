class PatientSerializer < ActiveModel::Serializer
	attributes :id, :email, :first_name, :last_name, :gender, :phone, :diagnosis,
						 :name, :last_message, :unread_messages_count, :visits_count,
						 :appointments_count, :diagnosises_count, :next_visit_date, :medical_profiles_attributes,
						 :invitation_accepted

	def last_message
		{
			text: Faker::Lorem.sentence,
			created_at: Time.now
		}
	end

	def unread_messages_count
		0
	end

	def appointments_count
		0
	end

	def diagnosises_count
		0
	end

	def visits_count
		0
	end

	def next_visit_date
		Time.now
	end

	def name
		[object.first_name, object.last_name].join " "
	end

	def diagnosis
		object.medical_profiles.first.diagnosis
	end

	def medical_profiles_attributes
		ActiveModel::Serializer::ArraySerializer.new(object.medical_profiles, each_serializer: MedicalProfileSerializer)
	end

	def invitation_accepted
		object.invitation_accepted?
	end

end
