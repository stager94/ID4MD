module PdmApp
	module Notifications
		class Sms

			include ::Plivo

			attr_accessor :number

			def initialize(params = {})
				params.each {|k, v| instance_variable_set "@#{k}", v }
			end

			def valid?
				user && valid_number?
			end

			def send!(message = nil)
				return unless message || valid?
				notify_user_with message
			end

		private

			def valid_number?
				# number && !number.phony_formatted(strict: true).nil?
				true
			end

			def api
				@_api ||= RestAPI.new SECRET_STORE["PLIVO_AUTH_ID"], SECRET_STORE["PLIVO_AUTH_TOKEN"]
			end

			def params(message)
				{
					src: "14154847489",
					dst: number,
					text: message
				}
			end

			def notify_user_with(message)
				api.send_message params(message)
			end

		end
	end
end
