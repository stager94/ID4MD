class API::V1::Doctors::PatientsController < API::V1::BaseController

	before_action :find_patient, only: [:show, :update]

	def index
		patients = Patient.where(invited_by_type: "Doctor", invited_by_id: current_doctor.id)
		render json_success("Invited patients list", { patients: ActiveModel::Serializer::ArraySerializer.new(patients, each_serializer: PatientSerializer) })
	end

	def show
		render json_success("User's profile", patient: PatientSerializer.new(@patient))
	end

	def update
		@patient.update params[:patient]
	end

private

  def permitted_params
    params[:patint].permit!
  end


	def find_patient
		@patient = Patient.find params[:id]
	end

end
