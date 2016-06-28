App.controller('Doctors.PatientsVisitsCtrl', ['$scope', '$rootScope', '$state', '$http', ($scope, $rootScope, $state, $http) ->
	$scope.visits = []

	$http.get("/api/v1/patients/dashboard/#{$state.params.id}/visits").success((data, status, header, config) ->
		$scope.visits = data.visits
	).error (data, state) ->
		alert data.message

])
