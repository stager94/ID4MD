module PdmApp
	module Chat
		class SendingMessage < PdmApp::Chat::Base
			
			def send!(medical_profile, sender, body, objectable = nil)
				message = ::Chat::Message.create medical_profile: medical_profile, 
																			 sender: sender, 
																			 body: body,
																			 objectable: objectable
			end

			def send_custom!(medical_profile, sender, object)
				o = object["type"].constantize.new object[:details].permit!
				o.medical_profile = medical_profile
				o.save

				if o.valid?
					send! medical_profile, sender, o.build_chat_message, o
				else
					o
				end
			end

		end
	end
end
