module PdmApp
	module Exceptions
		class AlreadyAuthorized < StandardError

			def code
				500
			end

			def message
				"500 AlreadyAuthorized"
			end

		end
	end
end
