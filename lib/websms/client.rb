module Websms
	class Client
		
		include Websms::Sms

		attr_accessor :username, :password

		def initialize(username, password)
			@username = username
			@password = password
		end

	end	
end
