App.controller('Doctors.PatientsChatCtrl', ['$scope', '$rootScope', '$state', '$http', ($scope, $rootScope, $state, $http) ->
	
	$scope.loaded = false
	$scope.messages = []
	$scope.offset = 0
	$scope.page = 1
	$scope.needLoad = true
	$scope.busy = false
	$scope.message = {}

	initialize = ->
		PdmApp.cable.subscriptions.create {
				channel: "ChatChannel",
				chat_room_id: $rootScope.patient.medical_profiles_attributes[0].id
			},
			received: (data) ->
				$scope.messages.push JSON.parse(data.message)
				$scope.$apply()

				setTimeout ->
					Page.onResize()
					$(".scrollable").scrollTop(1000);

		$scope.loadMessages()

	$scope.sendMessage = ->
		$http.post("/api/v1/doctors/medical_profiles/#{$rootScope.patient.medical_profiles_attributes[0].id}/chat/messages.json",
			body: $scope.message.text
		).success((data, status, header, config) ->
			console.log data, status, header, config
			# $scope.messages.push data.message
			$scope.message = {}

			setTimeout ->
				Page.onResize()
				$(".scrollable").scrollTop(1000);
		).error (data, status) ->
			console.log data, status

	$scope.loadMessages = ->
		if $scope.needLoad == false or $scope.busy == true
			return

		$scope.busy = true

		$http.get("/api/v1/doctors/medical_profiles/#{$rootScope.patient.medical_profiles_attributes[0].id}/chat/messages.json?page=#{$scope.page}").success((data, status, header, config) ->
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

	$scope.retrievePatient initialize

])
