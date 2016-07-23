class Api::V1::Patients::Chat::MessagesController < Api::V1::BaseController
	
	def index
		messages = ::Chat::Message.for_medical_profile(medical_profile.id).page(params[:page]).per(10)
		render json_success("Messages list", messages: serialize(messages))
	end

	def create
		use_case = ::PdmApp::Chat::SendingMessage.new
		message  = use_case.run medical_profile, current_patient, params[:body]
		serialized_message = ::Chat::MessageSerializer.new(message)
		
		# ActionCable.server.broadcast "messages_#{medical_profile.id}_channel", message: serialized_message.to_json
		PdmApp::SocketManager.broadcast "/messages/#{medical_profile.id}", message: serialized_message.as_json

		render json_success("Message created successfull", message: serialized_message)
	end

private

	def medical_profile
		@_medical_profile ||= MedicalProfile.find params[:id]
	end

	def serialize(messages_array)
		ActiveModel::Serializer::ArraySerializer.new(messages_array, each_serializer: ::Chat::MessageSerializer)
	end

end
