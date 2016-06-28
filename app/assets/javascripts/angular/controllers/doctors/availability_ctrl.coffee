App.controller('Doctors.AvailabilityCtrl', ['$scope', '$rootScope', 'security', '$state', '$http', ($scope, $rootScope, security, $state, $http) ->

	$scope.setAvailability = (availability) ->
		$http.put("/api/v1/doctors/profile/#{security.current_user.id}.json",
			doctor:
				availability: availability
		).success((data, status, header, config) ->
			security.current_user = data.user
		).error (data, status) ->
			alert(data.message)
])
