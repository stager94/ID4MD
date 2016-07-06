angular.module "security", ["security.service"]

angular.module("security.service", []).factory "security", [
	"$location",
	"$http",
	"$q",
	"$state",
	($location, $http, $q, $state) ->
		redirect = (url) ->
			$state.go url

		service = 
			showLogin: ->
				redirect "/login"

			hideLogin: ->
				redirect "/"

			login: (login, password) ->
				$http.post("/api/v1/patients/sign_in.json",
					patient:
						login: login,
						password: password
				).success((data, status, header, config) ->
					service.current_user = data.patient
					service.medical_profiles = data.patient.medical_profiles_attributes
					if service.isAuthenticated() then redirect('chat')
				).error (data, status) ->
					alert(data.message)

			signup: (params) ->
				$http.post("/api/v1/signup.json",
					user: params
				).success (data, status, header, config) ->
					service.current_user = data.user
					service.medical_profiles = data.user.medical_profiles_attributes
					if service.isAuthenticated() then redirect('chat')

			logout: (newState) ->
				$http.post("/api/v1/patients/sign_out.json").then (response) ->
					service.current_user = null
					service.medical_profiles = []
					return

			#update: (params, avatar_params) ->
			#	console.log "params:", params
			#	$http.post("api/v1/update_profile.json",
			#		avatar_params
			#		transformRequest: angular.identity,
			#		headers:
			#			"Content-Type": `undefined`
			#	).success (data, status, header, config) ->
			#		profile.user = null

			requestCurrentUser: (successCallback, errorCallback) ->
				if service.isAuthenticated()
					successCallback() if typeof successCallback is 'function'
					return service.current_user
				else
					service.reloadCurrentUser successCallback, errorCallback

			reloadCurrentUser: (successCallback, errorCallback) ->
				$http.get("/api/v1/patients/current_user.json").success((data, status) ->
					service.current_user = data.patient
					service.medical_profiles = data.patient.medical_profiles_attributes
					
					successCallback() if typeof successCallback is 'function'

					setTimeout ->
						floatedOptions.initialize()
					, 1
					
					return service.current_user
				).error (response) ->
					errorCallback() if typeof errorCallback is 'function'
					console.log response

			current_user: null
			medical_profiles: []

			isAuthenticated: ->
				!!service.current_user

		return service
]
