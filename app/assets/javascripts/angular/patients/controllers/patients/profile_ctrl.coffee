App.controller('Patients.ProfileCtrl', ['$scope', '$stateParams', '$state', '$http', 'security', '$rootScope' , ($scope, $stateParams, $state, $http, security, $rootScope) ->

	$scope.patientsFields = patientProfileFields

	$scope.update = (availability) ->
    $http.put("/api/v1/patients/dashboard/#{security.current_user.id}.json",
      patient: security.current_user
    ).success((data, status, header, config) ->
      security.current_user = data.user
    ).error (data, status) ->
      alert data.message

])
