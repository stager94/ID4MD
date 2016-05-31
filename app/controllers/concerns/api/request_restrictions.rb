module API::RequestRestrictions
	extend ActiveSupport::Concern

protected

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

end
