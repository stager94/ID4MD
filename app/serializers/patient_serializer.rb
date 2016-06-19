class PatientSerializer < ActiveModel::Serializer
	attributes :id, :email, :first_name, :last_name, :gender, :diagnosis, :phone, 
						 :last_message, :unread_messages_count,
						 :appointments_count, :diagnosises_count, :next_visit_date

	def last_message
		{
			text: Faker::Lorem.sentence,
			created_at: Time.now
		}
	end

	def unread_messages_count
		1
	end

	def appointments_count
		0
	end

	def diagnosises_count
		0
	end

	def next_visit_date
		Time.now
	end

end
