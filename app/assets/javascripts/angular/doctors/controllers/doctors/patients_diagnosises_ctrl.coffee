App.controller('Doctors.PatientsDiagnosisesCtrl', ['$scope', '$rootScope', '$state', '$http', ($scope, $rootScope, $state, $http) ->

	$scope.diagnosises = []

	loadDiagnosises = ->
		$http.get("/api/v1/patients/dashboard/medical_profiles/#{$rootScope.patient.medical_profiles_attributes[0].id}/diagnosises.json").success((data, status, header, config) ->
			$scope.diagnosises = data.diagnosises
			setTimeout ->
				Page.onResize()
			, 1
		).error (data, state) ->
			alert data.message

	$scope.retrievePatient loadDiagnosises


])
