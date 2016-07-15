module Chat
	module Senderable
		
	  extend ActiveSupport::Concern

	  included do

	    has_many :messages, class_name: "Chat::Message", as: :sender

	  end
	  
	end
end
