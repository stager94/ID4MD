class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :configure_permitted_parameters, if: :devise_controller?

  def demo
  	render layout: "demo"
  end

  def iphone6
  	render layout: "demo"
  end

  def doctors
    render layout: 'doctors', text: ""
  end

  def patients
    render layout: 'patients', text: ""
  end

 protected

  def json_request?
    request.format.json?
  end

  def configure_permitted_parameters
    added_attrs = [:phone, :email, :id, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
