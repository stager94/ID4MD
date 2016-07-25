App.controller('Doctors.PatientsChatFormCtrl', ['$scope', '$rootScope', '$state', '$http', ($scope, $rootScope, $state, $http) ->

	#
	# Public methods
	#

	$scope.sendMessage = ->
		$http.post("/api/v1/doctors/medical_profiles/#{$rootScope.patient.medical_profiles_attributes[0].id}/chat/messages.json",
			body: $scope.message.text
		).success((data, status, header, config) ->
			console.log data, status, header, config

			setTimeout ->
				Page.onResize()
				$(".scrollable").scrollTop(1000);
		).error (data, status) ->
			console.log data, status

	$scope.sendCustomMessage = (message) ->
		console.log message
		$http.post("/api/v1/doctors/medical_profiles/#{$rootScope.patient.medical_profiles_attributes[0].id}/chat/messages.json",
			custom: true
			object: message.object
		).success((data, status) ->
			console.log data, status
			message.hidden = true
		).error (data, status) ->
			console.log data, status


	$scope.addCustomForm = (type) ->
		$rootScope.messages.push
			id: generateCustomId()
			custom_type: "#{type}-form"
			date: capitalizeFirstLetter(moment().format('dddd DD MMMM YYYY'))
			created_at: new Date()
			custom: true
			object:
				type: capitalizeFirstLetter(type)
				secret: generateSecretId(10)

		setTimeout ->
				Page.onResize()
				$(".scrollable").scrollTop(1000);

	#
	# Private methods
	#

	generateCustomId = ->
		return $rootScope.messages[0].id

	generateSecretId = (count) ->
		text = ''
		possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
		i = 0
		while i < (count)
			text += possible.charAt(Math.floor(Math.random() * possible.length))
			i++
		text

	capitalizeFirstLetter = (string) ->
    return string.charAt(0).toUpperCase() + string.slice(1)

])
