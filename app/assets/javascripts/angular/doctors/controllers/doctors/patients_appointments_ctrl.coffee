App.controller('Doctors.PatientsAppointmentsCtrl', ['$scope', '$rootScope', '$state', '$http', ($scope, $rootScope, $state, $http) ->
	$scope.appointments = []

	$http.get("/api/v1/patients/dashboard/#{$state.params.id}/appointments").success((data, status, header, config) ->
		$scope.appointments = data.appointments
	).error (data, state) ->
		alert data.message

])
