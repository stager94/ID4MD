module PdmApp
	module SocketManager
		
		def self.broadcast(channel, object)
			message = { channel: channel, data: { data: object, type: "message" }, ext: { auth_token: Sync.auth_token } }
			uri = URI.parse("http://localhost:9292/faye")
			Net::HTTP.post_form(uri, message: message.to_json)
		end

	end
end
