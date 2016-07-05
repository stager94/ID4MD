class Api::V1::Patients::VisitsController < Api::V1::BaseController
	
	def index
		list = medical_profile.visits.following
		render json_success("Visits list", { 
			visits: ActiveModel::Serializer::ArraySerializer.new(list, each_serializer: VisitSerializer) 
			})
	end

private

	def medical_profile
		@_medical_profile ||= MedicalProfile.find params[:id]
	end

end
