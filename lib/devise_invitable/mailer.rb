require 'devise/version'

module DeviseInvitable
  module Mailer

    # Deliver an invitation email
    def invitation_instructions(record, token, opts={})
      @token = token
      a = PdmApp::Notifications::Sms.new(number: record.phone).send!("#{root_url}/patients#/invitation/#{record.invitation_token}/#{@token}/accept")
      p a
      # binding.pry
    end
  end
end
