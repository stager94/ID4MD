class AssetsController < ApplicationController
	
	def application
		
		respond_to do |format|
			format.css { render plain: Id4md::Application.assets.find_asset('application.css'), content_type: :css }
			format.any { render nothing: true }
		end
		
	end

end
