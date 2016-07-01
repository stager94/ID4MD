class API::V1::Patients::DiagnosisesController < API::V1::BaseController
	
	def index
		list = medical_profile.diagnosises.following
		render json_success("Diagnosises list", { 
			diagnosises: ActiveModel::Serializer::ArraySerializer.new(list, each_serializer: DiagnosisSerializer) 
			})
	end

private

	def medical_profile
		@_medical_profile ||= MedicalProfile.find params[:id]
	end
	
end
