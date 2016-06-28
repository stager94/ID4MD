App.controller('Doctors.DashboardCtrl', ['$scope', '$rootScope', 'security', '$state', '$http', ($scope, $rootScope, security, $state, $http) ->
	$scope.patients = []

	$http.get("/api/v1/doctors/patients.json").success((response) ->
		$scope.patients = response.patients
	).error (data, status) ->
		alert(data)

	$scope.search = (item) ->
		if !$scope.query || (item.name.toLowerCase().indexOf($scope.query) != -1) || (item.diagnosis.toLowerCase().indexOf($scope.query.toLowerCase()) != -1)
			return true
		return false

])
