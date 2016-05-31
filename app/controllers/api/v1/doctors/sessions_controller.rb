class API::V1::Doctors::SessionsController < Devise::SessionsController
  include API::RequestHelper
  include API::ExceptionsTriggering

  respond_to :json
  skip_before_filter :verify_signed_out_user
  before_action :authenticate_doctor!

  def create
    resource = warden.authenticate! scope: resource_name, recall: "#{controller_path}#failure"
    render json_success("Logged in", { user: current_doctor })
  end

  def destroy
    sign_out
    render json_success("Logged in")
  end

  def failure
    render json_failed("Login Credentials Failed", 401)
  end

  def get_current_user
    render json_success("Current user", { user: current_doctor })
  end

private

  def authenticate_doctor!
    return if doctor_signed_in?
    raise ::PdmApp::Exceptions::NotAuthorized.new
  end

end
