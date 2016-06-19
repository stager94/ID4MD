class API::V1::Doctors::PatientsController < API::V1::BaseController

	def index
		patients = Patient.where(invited_by_type: "Doctor", invited_by_id: current_doctor.id)
		render json_success("Invited patients list", { patients: ActiveModel::Serializer::ArraySerializer.new(patients, each_serializer: PatientSerializer) })
	end

end
