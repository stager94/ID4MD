class API::V1::Doctors::SessionsController < Devise::SessionsController
  include API::RequestHelper
  include API::ExceptionsTriggering

  respond_to :json

  skip_before_action :verify_signed_out_user, only: :destroy
  before_action :require_authentication, only: :get_current_user

  def create
    resource = warden.authenticate! auth_options
    sign_in resource_name, resource
    render json_success("Logged in", { user: current_doctor })
  end

  def destroy
    sign_out
    render json_success("Logged out")
  end

  def failure
    render json_failed("Login Credentials Failed", 401)
  end

  def get_current_user
    render json_success("Current user", { user: current_doctor })
  end

private

  def require_authentication
    return if doctor_signed_in?
    raise ::PdmApp::Exceptions::NotAuthorized.new
  end

  def require_no_authentication
    assert_is_devise_resource!
    return unless is_navigational_format?
    no_input = devise_mapping.no_input_strategies

    authenticated = if no_input.present?
      args = no_input.dup.push scope: resource_name
      warden.authenticate?(*args)
    else
      warden.authenticated?(resource_name)
    end

    if authenticated && resource = warden.user(resource_name)
      raise ::PdmApp::Exceptions::AlreadyAuthorized.new
    end
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#failure" }
  end

end
