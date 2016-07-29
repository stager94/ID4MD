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
				@_api ||= ::Websms::Client.new Rails.application.secrets.websms_username, Rails.application.secrets.websms_password
			end

			def params(message)
				{
					to: number,
					text: message
				}
			end

			def notify_user_with(message)
				api.send! params(message)
			end

		end
	end
end
