App.controller('DiagnosisesCtrl', ['$scope', '$rootScope', '$state', '$http', 'security', ($scope, $rootScope, $state, $http, security) ->
	$scope.diagnosises = []	

	loadDiagnosises = ->
		$http.get("/api/v1/patients/dashboard/medical_profiles/#{security.medical_profiles[0].id}/diagnosises").success((data, status, header, config) ->
			$scope.diagnosises = data.diagnosises
			setTimeout ->
				Page.onResize()
			, 1
		).error (data, state) ->
			alert data.message

	security.requestCurrentUser loadDiagnosises, null

])
