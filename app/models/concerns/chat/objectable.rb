module Chat
	module Objectable
		
	  extend ActiveSupport::Concern

	  included do

	    has_many :messages, class_name: "Chat::Message", as: :objectable

	  end
	  
	end
end
