module Chat
	class MessageSerializer < ActiveModel::Serializer
		attributes :id, :body, :sender, :objectable, :type, :created_at, :date, :sender_type

		def sender
			sender_serializer.new object.sender
		end

		def objectable
			objectable_serializer.new object.objectable if objectable_serializer
		end

	private

		def sender_serializer
			prepare_serializer "#{object.sender_type}Short"
		end

		def objectable_serializer
			prepare_serializer object.objectable_type
		end

		def prepare_serializer(type)
			return if !type.present?
			"#{type}Serializer".constantize
		end

	end
end
