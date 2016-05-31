class API::V1::Doctors::InvitationsController < Devise::InvitationsController
	include API::RequestHelper
  include API::ExceptionsTriggering
  include API::RequestRestrictions

  before_action :authenticate_doctor!, only: :create
  before_action :require_no_authentication, only: :update

  def create
    user = Doctor.invite!(invite_params, current_doctor)
    render json_success('User created', user: DoctorSerializer.new(user))
  end

  def update
    doctor = Doctor.accept_invitation!(accept_invitation_params)
    
    if doctor.valid?
    	render json_success('Doctor updated.')
    else
    	if doctor.new_record?
	    	render json_failed('Invalid invitation token', 422)
	    else
	    	render json_failed('An error occured', 422, { errors: doctor.errors.full_messages })
	    end
    end
  end

  private

  def invite_params
    params.require(:doctor).permit(:email)
  end

  def accept_invitation_params
    params.permit(:password, :password_confirmation, :invitation_token)
  end
	
end
