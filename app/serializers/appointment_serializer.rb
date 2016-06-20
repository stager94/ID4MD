class AppointmentSerializer < ActiveModel::Serializer
	attributes :id, :date, :text

	def date
		object.date.strftime "%d %A %Y"
	end
end
