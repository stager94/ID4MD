class JobSerializer < ActiveModel::Serializer
	attributes :id, :address

	def address
		object.full_address
	end
end
