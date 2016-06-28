App.controller('Doctors.ProfileCtrl', ['$scope', '$rootScope', 'security', '$state', '$http', ($scope, $rootScope, security, $state, $http) ->
	$scope.doctorFields = doctorFields

	$scope.update = (availability) ->
		$http.put("/api/v1/doctors/profile/#{security.current_user.id}.json",
			doctor: security.current_user
		).success((data, status, header, config) ->
			security.current_user = data.user
		).error (data, status) ->
			alert(data.errors)

])
