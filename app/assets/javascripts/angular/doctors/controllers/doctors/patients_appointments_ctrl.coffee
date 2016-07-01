App.controller('Doctors.PatientsAppointmentsCtrl', ['$scope', '$rootScope', '$state', '$http', ($scope, $rootScope, $state, $http) ->
	$scope.appointments = []

	loadAppointments = ->
		$http.get("/api/v1/patients/dashboard/medical_profiles/#{$rootScope.patient.medical_profiles_attributes[0].id}/appointments.json").success((data, status, header, config) ->
			$scope.appointments = data.appointments
			setTimeout ->
				Page.onResize()
			, 1
		).error (data, state) ->
			alert data.message

	$scope.retrievePatient loadAppointments

])
