window.doctorFields = [
	{
		name: 'name'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'security.current_user.first_name'
		label: "Имя"
	}
	{
		name: 'last_name'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'security.current_user.last_name'
		label: "Фамилия"
	}
	{
		name: 'speciality'
		templateUrl: 'templates/doctors/ui/forms/text.html'
		ngModel: 'security.current_user.speciality'
		label: "Специальность"
	}
	{
		name: 'gender'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'security.current_user.gender'
		label: "Пол"
	}
	{
		templateUrl: 'templates/doctors/ui/forms/delimiter.html'
	}
	{
		name: 'phone'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'security.current_user.phone'
		label: "Номер телефона"
	}
	{
		name: 'password'
		templateUrl: 'templates/doctors/ui/forms/string.html'
		ngModel: 'security.current_user.password'
		label: "Пароль"
	}
]
