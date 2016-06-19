App.controller('Doctors.PatientsInvitationCtrl', ['$scope', '$rootScope', 'security', '$state', '$http', ($scope, $rootScope, security, $state, $http) ->
	$scope.patient = {
		invited: false
	}

	$scope.patientsFields = newPatientFields

	$scope.invitePatient = ->
		http.post("api/v1/patients/invitation",
			patient: $scope.patient
		).success((data, status, header, config) ->
			$scope.patient.id = data.user.id
			$scope.patient.invited = true
		).error (data, status) ->
			alert(data.errors.join("\n"))
])
