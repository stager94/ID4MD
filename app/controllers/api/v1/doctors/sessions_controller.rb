class API::V1::Doctors::SessionsController < Devise::SessionsController
  include API::RequestHelper
  include API::ExceptionsTriggering
  include API::RequestRestrictions

  respond_to :json

  skip_before_action :verify_signed_out_user, only: :destroy
  before_action :require_doctor_authentication, only: :get_current_user

  def create
    resource = warden.authenticate! auth_options
    sign_in resource_name, resource
    render json_success("Logged in", { doctor: DoctorSerializer.new(current_doctor) })
  end

  def destroy
    sign_out
    render json_success("Logged out")
  end

  def failure
    render json_failed("Login Credentials Failed", 401)
  end

  def get_current_user
    render json_success("Current user", { doctor: DoctorSerializer.new(current_doctor) })
  end

private

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#failure" }
  end

end
