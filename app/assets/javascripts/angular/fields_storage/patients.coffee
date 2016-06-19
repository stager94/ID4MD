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
		ngModel: 'patient.diagnosis'
		label: 'Диагноз/Жалобы'
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
