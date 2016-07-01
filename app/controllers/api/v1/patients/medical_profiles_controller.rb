class API::V1::Patients::MedicalProfilesController < API::V1::BaseController
	
	before_action :find_medical_profile

	def show
		render json_success("Patient's medical profile", medical_profile: MedicalProfileSerializer.new(@medical_profile))
	end

private

	def find_medical_profile
		@medical_profile = MedicalProfile.find params[:id]
	end

end
