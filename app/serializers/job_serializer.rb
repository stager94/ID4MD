class JobSerializer < ActiveModel::Serializer
	attributes :id, :address, :name, :full_address

	def full_address
		object.full_address
	end
end
