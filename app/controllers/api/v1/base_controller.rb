class Api::V1::BaseController < ApplicationController
	respond_to :json

	include Api::ExceptionsTriggering
	include Api::RequestRestrictions

end
