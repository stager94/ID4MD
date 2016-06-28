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
