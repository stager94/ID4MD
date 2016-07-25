App.controller('Doctors.PatientsChatCtrl', ['$scope', '$rootScope', '$state', '$http', '$controller', ($scope, $rootScope, $state, $http, $controller) ->
	
	$controller('Doctors.PatientsChatFormCtrl', { $scope: $scope })

	#
	# Initial variables
	#

	$scope.loaded = false
	$rootScope.messages = []
	$scope.offset = 0
	$scope.page = 1
	$scope.needLoad = true
	$scope.busy = false
	$scope.message = {}

	#
	# Public methods
	#
	$scope.loadMessages = ->
		if $scope.needLoad == false or $scope.busy == true
			return

		$scope.busy = true

		$http.get("/api/v1/doctors/medical_profiles/#{$rootScope.patient.medical_profiles_attributes[0].id}/chat/messages.json?page=#{$scope.page}").success((data, status, header, config) ->
			console.log data, status, header, config
			
			if data.messages.length > 0
				Array.prototype.unshift.apply $rootScope.messages, data.messages
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

	#
	# Private methods
	#
	initialize = ->
		client = new Faye.Client Settings.faye_path
		client.subscribe "/messages/#{$rootScope.patient.medical_profiles_attributes[0].id}", (response) ->
			$rootScope.messages.push response.data.message
			$scope.$apply()

			setTimeout ->
				Page.onResize()
				$(".scrollable").scrollTop(1000);

		$scope.loadMessages()


	#
	# Other
	#

	$scope.retrievePatient initialize

])
