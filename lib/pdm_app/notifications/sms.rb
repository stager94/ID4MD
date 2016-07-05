module PdmApp
	module Notifications
		class Sms

			attr_accessor :number

			def initialize(params = {})
				params.each {|k, v| instance_variable_set "@#{k}", v }
			end

			def valid?
				valid_number?
			end

			def send!(message = nil)
				return unless message || valid?
				notify_user_with message
			end

		private

			def valid_number?
				number && !number.phony_formatted(strict: true).nil?
			end

			def api
				@_api ||= Twilio::REST::Client.new Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token
			end

			def params(message)
				{
					from: Rails.application.secrets.twilio_number,
					to: number,
					body: message
				}
			end

			def notify_user_with(message)
				api.messages.create params(message)
			end

		end
	end
end
