module API::ExceptionsTriggering
	extend ActiveSupport::Concern

	include API::RequestHelper

	included do
		rescue_from ::StandardError do |exception|
			render json_failed(exception.message, exception.try(:code) || 500, { name: exception.class.name })
		end
	end
	
end
