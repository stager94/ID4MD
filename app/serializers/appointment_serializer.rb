class AppointmentSerializer < ActiveModel::Serializer
	attributes :id, :date, :text

	def date
		Russian::strftime object.date, "%d %b %Y"
	end
end
