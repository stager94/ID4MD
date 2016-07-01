class DiagnosisSerializer < ActiveModel::Serializer
	attributes :id, :date, :laboratory, :address
end
