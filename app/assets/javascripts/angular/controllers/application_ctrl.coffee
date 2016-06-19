App.controller('ApplicationCtrl', ['$scope', '$rootScope', 'security', '$state', ($scope, $rootScope, security, $state) ->
  console.log "In AppCtrl"
  $scope.security = security
  $scope.user = {}

  $scope.logout = ->
    security.logout()
    $state.go "login"

  $scope.login = ->
	  console.log "login"
  	security.login $scope.user.email, $scope.user.password
])
