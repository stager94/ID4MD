class API::V1::BaseController < ApplicationController
	respond_to :json

	include API::ExceptionsTriggering

end
