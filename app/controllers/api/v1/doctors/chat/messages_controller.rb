# require "pdm_app/chat/sending_message"
# require "pdm_app/socket_manager"

class Api::V1::Doctors::Chat::MessagesController < Api::V1::BaseController
	
	def index
		messages = ::Chat::Message.for_medical_profile(medical_profile.id).page(params[:page]).per(10)
		render json_success("Messages list", messages: serialize(messages))
	end

	def create
		use_case = ::PdmApp::Chat::SendingMessage.new

		if params[:custom].present?
			message  = use_case.send_custom! medical_profile, current_doctor, params[:object]
		else
			message  = use_case.send! medical_profile, current_doctor, params[:body]
		end
		
		if message.valid?
			serialized_message = ::Chat::MessageSerializer.new(message)
			::PdmApp::SocketManager.broadcast "/messages/#{medical_profile.id}", message: serialized_message.as_json

			render json_success("Message created successfull", message: serialized_message)
		else
			render json_failed("An error occured", 422, { errors: message.errors })
		end
	end

private

	def medical_profile
		@_medical_profile ||= MedicalProfile.find params[:medical_profile_id]
	end

	def serialize(messages_array)
		ActiveModel::Serializer::ArraySerializer.new(messages_array, each_serializer: ::Chat::MessageSerializer)
	end

end
