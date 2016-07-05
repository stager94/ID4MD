module Api::RequestHelper
	
	def json_success(message, additional_hash = {})
		{
			status: 200, 
			json: {
				success: true,
				message: message
			}.merge(additional_hash)
		}
	end

	def json_failed(message, status, additional_hash = {})
		{
			status: status,
			json: {
				success: false,
				message: message
			}.merge(additional_hash)
		}
	end

end
