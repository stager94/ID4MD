class API::V1::Doctors::MedicalProfilesController < API::V1::BaseController

	before_action :find_patient, only: [:show, :update]

	def index
		patients = Patient.joins(:medical_profiles).where(medical_profiles: { doctor_id: current_doctor.id })
		
		# patients = Patient.where(invited_by_type: "Doctor", invited_by_id: current_doctor.id)
		render json_success("Invited patients list", { patients: ActiveModel::Serializer::ArraySerializer.new(patients, each_serializer: PatientSerializer) })
	end

	def show
		render json_success("User's profile", patient: PatientSerializer.new(@patient))
	end

	def update
		@patient.update permitted_params
		if @patient.valid?
			render json_success("User's profile", patient: PatientSerializer.new(@patient))
		else
			render json_failed("Bad request", 422, { errors: @patient.errors.full_messages, message: @patient.errors.full_messages.join("\n") })
		end
	end

private

  def permitted_params
    params[:patient].permit(:first_name, :last_name, :email, :diagnosis, :gender, :phone)
  end


	def find_patient
		@patient = Patient.find params[:id]
	end

end
