module PdmApp
	module Exceptions
		class NotAuthorized < StandardError

			def code
				401
			end

			def message
				"401 Unauthorized"				
			end

		end
	end
end
