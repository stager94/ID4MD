module PdmApp
	module Chat
		class SendingMessage < PdmApp::Chat::Base
			
			def run(medical_profile, sender, body, objectable = nil)
				message = ::Chat::Message.create medical_profile: medical_profile, 
																			 sender: sender, 
																			 body: body,
																			 objectable: objectable
			end

		end
	end
end
