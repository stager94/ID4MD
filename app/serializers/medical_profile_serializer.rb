class MedicalProfileSerializer < ActiveModel::Serializer
	attributes :id, :diagnosis

	belongs_to :doctor, serializer: DoctorSerializer
end
