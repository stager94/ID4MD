App.controller('ChatCtrl', ['$scope', '$rootScope', '$state', '$http', 'security', ($scope, $rootScope, $state, $http, security) ->
	
	$scope.loaded = false
	$scope.messages = []
	$scope.offset = 0
	$scope.page = 1
	$scope.needLoad = true
	$scope.busy = false
	$scope.message = {}

	$scope.sendMessage = ->
		$http.post("/api/v1/patients/dashboard/medical_profiles/#{security.medical_profiles[0].id}/chat/messages.json",
			body: $scope.message.text
		).success((data, status, header, config) ->
			console.log data, status, header, config
			$scope.messages.push data.message
			$scope.message = {}

			setTimeout ->
				Page.onResize()
				$(".scrollable").scrollTop(1000);
		).error (data, status) ->
			console.log data, status

	$scope.loadMessages = ->
		console.log security.current_user, security.medical_profiles
		if $scope.needLoad == false or $scope.busy == true
			return

		$scope.busy = true

		$http.get("/api/v1/patients/dashboard/medical_profiles/#{security.medical_profiles[0].id}/chat/messages.json?page=#{$scope.page}").success((data, status, header, config) ->
			console.log data, status, header, config
			
			if data.messages.length > 0
				Array.prototype.unshift.apply $scope.messages, data.messages
			else
				$scope.needLoad = false

			setTimeout ->
				Page.onResize()
				if $scope.page == 1
					$(".scrollable").scrollTop(1000);

				$scope.page += 1
				$scope.busy = false
			, 1

		).error (data, status) ->
			console.log data, status
			$scope.busy = false

	security.requestCurrentUser $scope.loadMessages

])
