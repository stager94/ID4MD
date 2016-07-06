window.newPatientFields = [
	{
		name: 'email'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'patient.email'
		label: "Email"
	}
	{
		name: 'first_name'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'patient.first_name'
		label: 'Имя'
	}
	{
		name: 'last_name'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'patient.last_name'
		label: 'Фамилия'
	}
	{
		name: 'diagnosis'
		templateUrl: 'templates/doctors/ui/forms/text.html'
		ngModel: 'patient.medical_profiles_attributes[0].diagnosis'
		label: 'Диагноз/Жалобы'
	}
	{
		name: 'medical_profile_id'
		templateUrl: 'templates/doctors/ui/forms/hidden.html'
		ngModel: 'patient.medical_profiles_attributes[0].id'
		label: 'Идентификатор'
	}
	{
		name: 'gender'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'patient.gender'
		label: 'Пол'
	}
	{
		name: 'phone'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'patient.phone'
		label: 'Телефон'
	}
]

window.acceptPatientFields = [
	{
		name: 'phone'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'patient.phone'
		label: 'Телефон'
	}
	{
		name: 'password'
		templateUrl: 'templates/doctors/ui/forms/password.html'
		ngModel: 'patient.password'
		label: 'Пароль'
	}
	{
		name: 'invitation_token'
		templateUrl: 'templates/doctors/ui/forms/hidden.html'
		ngModel: 'patient.invitation_token'
		label: 'Token'
	}
]

window.updatePatientFields = [
	{
		name: 'first_name'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'patient.first_name'
		label: 'Имя'
	}
	{
		name: 'last_name'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'patient.last_name'
		label: 'Фамилия'
	}
]

window.patientProfileFields = [
	{
		name: 'email'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'security.current_user.email'
		label: "Email"
	}
	{
		name: 'first_name'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'security.current_user.first_name'
		label: 'Имя'
	}
	{
		name: 'last_name'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'security.current_user.last_name'
		label: 'Фамилия'
	}
	{
		name: 'diagnosis'
		templateUrl: 'templates/doctors/ui/forms/text.html'
		ngModel: 'security.current_user.medical_profiles_attributes[0].diagnosis'
		label: 'Диагноз/Жалобы'
	}
	{
		name: 'medical_profile_id'
		templateUrl: 'templates/doctors/ui/forms/hidden.html'
		ngModel: 'security.current_user.medical_profiles_attributes[0].id'
		label: 'Идентификатор'
	}
	{
		name: 'gender'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'security.current_user.gender'
		label: 'Пол'
	}
	{
		name: 'phone'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'security.current_user.phone'
		label: 'Телефон'
	}
]
