App.controller('VisitsCtrl', ['$scope', '$rootScope', '$state', '$http', 'security', ($scope, $rootScope, $state, $http, security) ->
	$scope.visits = []

	$rootScope.$on "loaded-current-patient", (event, data) ->
		$http.get("/api/v1/patients/dashboard/#{security.medical_profiles[0].id}/visits").success((data, status, header, config) ->
			$scope.visits = data.visits
			setTimeout ->
				Page.onResize()
			, 1
		).error (data, state) ->
			alert data.message

])
