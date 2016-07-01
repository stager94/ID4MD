App.controller('Doctors.PatientsCtrl', ['$scope', '$rootScope', '$state', '$http', ($scope, $rootScope, $state, $http) ->
  $rootScope.patient = {}
  $scope.patientsFields = newPatientFields

  loadPatient = (successCallback) ->
    $http.get("/api/v1/doctors/patients/#{$state.params.id}.json").success((data, status, header, config) ->
      $rootScope.patient = data.patient
      setTimeout ->
        floatedOptions.initialize()
      , 1
      successCallback() if typeof successCallback is 'function'
    ).error (data, state) ->
      alert data.message

  loadMedicalProfile = ->
    $http.get("/api/v1/patients/dashboard/medical_profiles/#{$rootScope.patient.medical_profiles_attributes[0].id}.json").success((data, status) ->
      console.log data, status
      $scope.medical_profile = data.medical_profile
    ).error (data, status) ->
      console.log data, status
      alert data.messages

  $scope.retrievePatient = (successCallback) ->
    if $rootScope.patient.id
      successCallback()
    else
      loadPatient successCallback

  $scope.update = ->
    $http.put("/api/v1/doctors/patients/#{$scope.patient.id}",
      patient: $scope.patient
    ).success((data, status, header, config) ->
      $rootScope.patient = data.patient
    ).error (data, status) ->
      alert data.message

  loadPatient loadMedicalProfile
])
