class Api::V1::Patients::PatientsController < Api::V1::BaseController

	before_filter :find_patient

	def update
		@patient.update permitted_params
		if @patient.valid?
			render json_success("Patient profile updated", user: PatientSerializer.new(@patient))
		else
			render json_failed("", 422, errors: @patient.errors.full_messages )
		end
	end

private

	def find_patient
		@patient = Patient.find params[:id]
	end

	def permitted_params
		params.require(:patient).permit :availability, :first_name, :last_name, :speciality, :phone, :password, :gender
	end

end
