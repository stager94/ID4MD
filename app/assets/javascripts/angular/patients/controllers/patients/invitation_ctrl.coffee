App.controller('Patients.InvitationCtrl', ['$scope', '$stateParams', '$state', '$http', 'security', ($scope, $stateParams, $state, $http, security) ->
  console.log "In HomeCtrl"
  $scope.loaded = false
  $scope.step = 0;
  $scope.patient = {}
  $scope.acceptPatientFields = acceptPatientFields
  $scope.updatePatientFields = updatePatientFields

  $http.get("/api/v1/patients/invitations/info/#{$stateParams.token}.json").success((data, status, header, config) ->
    console.log data
    $scope.patient = data.patient
    $scope.patient.invitation_token = $stateParams.secret
    $scope.loaded = true
  ).error (data, status) ->
    $state.go 'login'


  $scope.begin = ->
    $scope.step = 1
    setTimeout ->
      floatedOptions.initialize()
    , 1

  $scope.accept = ->
    $http.put("/api/v1/patients/invitation.json",
      patient: $scope.patient
    ).success((data, status, header, config) ->
      console.log "success", data, status
      $scope.step = 2
    ).error (data, status) ->
      alert data.errors
      console.log "error", data, status

  $scope.update = ->
    $http.put("/api/v1/patients/dashboard/#{$scope.patient.id}.json",
      patient: $scope.patient
    ).success((data, status, header, config) ->
      $scope.patient = data.patient
      $scope.step = 3
    ).error (data, status) ->
      alert(data.errors)
])
