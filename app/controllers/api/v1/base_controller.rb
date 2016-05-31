class API::V1::BaseController < ApplicationController
	respond_to :json

	rescue_from StandardError do |exception|
    render json: { :error => exception.message }, :status => 500
	end
end
