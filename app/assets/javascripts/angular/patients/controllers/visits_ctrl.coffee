App.controller('VisitsCtrl', ['$scope', '$rootScope', '$state', '$http', 'security', ($scope, $rootScope, $state, $http, security) ->

	$scope.visits = []

	loadVisits = ->
		$http.get("/api/v1/patients/dashboard/medical_profiles/#{security.medical_profiles[0].id}/visits").success((data, status, header, config) ->
			$scope.visits = data.visits
			setTimeout ->
				Page.onResize()
			, 1
		).error (data, state) ->
			alert data.message

	security.requestCurrentUser loadVisits, null

])
