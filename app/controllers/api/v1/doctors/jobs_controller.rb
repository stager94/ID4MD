class Api::V1::Doctors::JobsController < Api::V1::BaseController
	
	def create
		job = current_doctor.jobs.create params.require(:job).permit!
		if job.valid?
			render json_success("New job", job: JobSerializer.new(job))
		else
			render json_failed("Bad request", 422, { errors: job.errors.full_messages, message: job.errors.full_messages.join("\n") })
		end
	end

	def destroy
		job = Job.find params[:id]
		job.destroy
		render json_success("job_destroyed", job: JobSerializer.new(job))
	end

end
