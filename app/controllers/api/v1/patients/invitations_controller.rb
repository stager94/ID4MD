class API::V1::Patients::InvitationsController < Devise::InvitationsController
	include Api::RequestHelper
  include API::ExceptionsTriggering
  include API::RequestRestrictions

  prepend_before_action :require_doctor_authentication, only: :create
  skip_before_action :authenticate_inviter!
  skip_before_action :has_invitations_left?
  before_action :require_no_authentication, only: :update

  def create
    user = Patient.invite!(invite_params, current_doctor)

    if user.valid?
      user.medical_profiles.create doctor_id: current_doctor.id, diagnosis: params[:patient][:medical_profiles_attributes]["0"][:diagnosis] if user.medical_profiles.count == 0
      render json_success('Patient created', user: PatientSerializer.new(user))
    else
      render json_failed('An error occured', 422, { errors: user.errors.full_messages })
    end
  end

  def update
    patient = Patient.accept_invitation!(accept_invitation_params)
    
    if patient.valid?
    	render json_success('Patient updated.')
    else
    	if patient.new_record?
	    	render json_failed('Invalid invitation token', 422, { errors: ["Invalid invitation token"] })
	    else
	    	render json_failed('An error occured', 422, { errors: patient.errors.full_messages })
	    end
    end
  end

  def get_user_info
    patient = Patient.find_by(invitation_token: params[:token])
    if patient
      render json_success('Patient info', patient: PatientSerializer.new(patient))
    else
      render json_failed('Not found', 404, {})
    end
  end

private

  def invite_params
    params[:patient].permit(:email, :first_name, :last_name, :diagnosis, :gender, :phone)
  end

  def accept_invitation_params
    params[:patient].permit(:password, :password_confirmation, :invitation_token)
  end

end
