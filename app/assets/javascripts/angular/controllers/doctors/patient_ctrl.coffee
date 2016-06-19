App.controller('Doctors.PatientsCtrl', ['$scope', '$state', '$http', ($scope, $state, $http) ->
	$scope.patient = {}
	$scope.patientsFields = newPatientFields

	$http.get("/api/v1/doctors/patients/#{$state.params.id}").success((data, status, header, config) ->
		$scope.patient = data.patient
		setTimeout ->
			floatedOptions.initialize()
		, 1
	).error (data, state) ->
		alert data.message

	$scope.update = ->
		$http.put("/api/v1/doctors/patients/#{$scope.patient.id}",
			patient: $scope.patient
		).success((data, status, header, config) ->
			$scope.patient = data.patient
		).error (data, status) ->
			alert data.message
])
