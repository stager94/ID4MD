class API::V1::Patients::InvitationsController < Devise::InvitationsController
	include API::RequestHelper
  include API::ExceptionsTriggering
  include API::RequestRestrictions

  prepend_before_action :require_doctor_authentication, only: :create
  before_action :require_no_authentication, only: :update

  def create
    user = Patient.invite!(invite_params, current_doctor)
    render json_success('Patient created', user: PatientSerializer.new(user))
  end

  def update
    patient = Patient.accept_invitation!(accept_invitation_params)
    
    if patient.valid?
    	render json_success('Doctor updated.')
    else
    	if patient.new_record?
	    	render json_failed('Invalid invitation token', 422)
	    else
	    	render json_failed('An error occured', 422, { errors: patient.errors.full_messages })
	    end
    end
  end

private

  def invite_params
    params.require(:patient).permit(:email)
  end

  def accept_invitation_params
    params.permit(:password, :password_confirmation, :invitation_token)
  end
	
end