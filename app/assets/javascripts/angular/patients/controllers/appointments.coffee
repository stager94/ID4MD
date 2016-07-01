App.controller('AppointmentsCtrl', ['$scope', '$rootScope', '$state', '$http', 'security', ($scope, $rootScope, $state, $http, security) ->
	$scope.appointments = []

	loadAppointments = ->
		$http.get("/api/v1/patients/dashboard/#{security.medical_profiles[0].id}/appointments").success((data, status, header, config) ->
			$scope.appointments = data.appointments
			setTimeout ->
				Page.onResize()
			, 1
		).error (data, state) ->
			alert data.message

	security.requestCurrentUser loadAppointments, null

])
