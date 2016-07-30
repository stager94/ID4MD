App.controller('Doctors.JobsCtrl', ['$scope', '$rootScope', 'security', '$state', '$http', ($scope, $rootScope, security, $state, $http) ->

	initialize = ->
		$scope.jobs = security.current_user.jobs

	$scope.newJob = ->
		$scope.jobs.push
			id: -1
			object:
				name: ""
				address: ""
			hidden: false

	$scope.createJob = (job) ->
		$http.post("/api/v1/doctors/profile/jobs.json",
			job: job.object
		).success((data, status) ->
			console.log data, status
			job.hidden = true
			$scope.jobs.push data.job
		).error (data, status) ->
			console.log data, status

	$scope.destroyJob = (job) ->
		$http.delete("/api/v1/doctors/profile/jobs/#{job.id}.json").success((data, status) ->
			console.log data, status
			job.hidden = true
		).error (data, status) ->
			console.log data, status


	security.requestCurrentUser initialize
])
