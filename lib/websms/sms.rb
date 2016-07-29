module Websms
	module Sms
		
		include Websms::Constants

		def send!(params)
			Curl.post HTTP_BASE_URL, build_params(params)
		end

	private

		def build_params(params)
			{
				http_username: username,
				http_password: password,
				message: params[:text],
				phone_list: params[:to]
			}
		end

	end
end
