class API::V1::Doctors::DoctorsController < API::V1::BaseController

	before_filter :find_doctor

	def update
		@doctor.update permitted_params
		if @doctor.valid?
			render json_success("Doctor profile updated", user: DoctorSerializer.new(@doctor))
		else
			render json_failed("", 422, errors: @doctor.errors.full_messages )
		end
	end

private

	def find_doctor
		@doctor = Doctor.find params[:id]
	end

	def permitted_params
		params.require(:doctor).permit :availability, :first_name, :last_name, :speciality, :phone, :password, :gender
	end

end
