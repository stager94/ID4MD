App.controller('Doctors.JobsCtrl', ['$scope', '$rootScope', 'security', '$state', '$http', ($scope, $rootScope, security, $state, $http) ->

	initialize = ->
		$scope.jobs = security.current_user.jobs

	$scope.newJob = ->
		$scope.jobs.push
			id: -1
			name: ""
			address: ""

	security.requestCurrentUser initialize
])
