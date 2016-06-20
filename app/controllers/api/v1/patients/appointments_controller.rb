class API::V1::Patients::AppointmentsController < API::V1::BaseController

	before_action :find_patient, only: [:index]
	
	def index
		list = medical_profile.appointments.where("date >= ?", Date.today)
		render json_success("Appointments list", { 
			appointments: ActiveModel::Serializer::ArraySerializer.new(list, each_serializer: AppointmentSerializer) 
			})
	end

private

	def find_patient
		@patient = Patient.find params[:id]
	end

	def medical_profile
		@patient.medical_profile_for(current_doctor)
	end

end
