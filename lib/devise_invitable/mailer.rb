require 'devise/version'

module DeviseInvitable
  module Mailer

  	require 'pdm_app/notifications/sms'

    # Deliver an invitation email
    def invitation_instructions(record, token, opts={})
      @token = token
      ::PdmApp::Notifications::Sms.new(number: record.phone).send!("Hello, #{root_url}/patients#/invitation/#{record.invitation_token}/#{@token}/accept")
    end
  end
end
