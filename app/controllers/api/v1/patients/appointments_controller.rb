class API::V1::Patients::AppointmentsController < API::V1::BaseController
	
	def index
		list = medical_profile.appointments.following
		render json_success("Appointments list", { 
			appointments: ActiveModel::Serializer::ArraySerializer.new(list, each_serializer: AppointmentSerializer) 
			})
	end

private

	def medical_profile
		@_medical_profile ||= MedicalProfile.find params[:id]
	end

end
