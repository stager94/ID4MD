App.controller('DashboardCtrl', ['$scope', '$rootScope', 'security', '$http', ($scope, $rootScope, security, $http) ->
  $scope.doctor = {}
  $scope.medical_profile = {}
  
  loadMedicalProfile = ->
	  $http.get("/api/v1/patients/dashboard/medical_profiles/#{security.medical_profiles[0].id}.json").success((data, status) ->
	    console.log data, status
	    $scope.doctor = data.medical_profile.doctor
	    $scope.medical_profile = data.medical_profile
	  ).error (data, status) ->
	    console.log data, status
	    alert data.messages

  security.requestCurrentUser loadMedicalProfile, null

])
