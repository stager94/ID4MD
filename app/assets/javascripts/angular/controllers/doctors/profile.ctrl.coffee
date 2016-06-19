App.controller('Doctors.ProfileCtrl', ['$scope', '$rootScope', 'security', '$state', '$http', ($scope, $rootScope, security, $state, $http) ->
	$scope.patients = []

	$http.get("/api/v1/doctors/profile/#{security.requestCurrentUser.id}/patients.json").success((response) ->
		$scope.patients = response.patients
		setTimeout ->
			SwipedPatientsPanels.initialize()
		, 100
	).error ->
		alert(error)

])
