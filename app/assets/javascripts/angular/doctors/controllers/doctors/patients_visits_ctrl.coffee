App.controller('Doctors.PatientsVisitsCtrl', ['$scope', '$rootScope', '$state', '$http', ($scope, $rootScope, $state, $http) ->

	$scope.visits = []

	loadVisits = ->
		$http.get("/api/v1/patients/dashboard/medical_profiles/#{$rootScope.patient.medical_profiles_attributes[0].id}/visits.json").success((data, status, header, config) ->
			$scope.visits = data.visits
			setTimeout ->
				Page.onResize()
			, 1
		).error (data, state) ->
			alert data.message

	$scope.retrievePatient loadVisits

])
