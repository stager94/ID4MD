class Api::V1::Doctors::Chat::MessagesController < Api::V1::BaseController
	
	def index
		messages = ::Chat::Message.for_medical_profile(medical_profile.id).page(params[:page]).per(10)
		render json_success("Messages list", messages: serialize(messages))
	end

	def create
		use_case = ::PdmApp::Chat::SendingMessage.new
		message  = use_case.run medical_profile, current_doctor, params[:body]
		render json_success("Message created successfull", message: ::Chat::MessageSerializer.new(message))
	end

private

	def medical_profile
		@_medical_profile ||= MedicalProfile.find params[:medical_profile_id]
	end

	def serialize(messages_array)
		ActiveModel::Serializer::ArraySerializer.new(messages_array, each_serializer: ::Chat::MessageSerializer)
	end

end
