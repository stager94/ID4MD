angular.module "security", ["security.service"]

angular.module("security.service", []).factory "security", [
	"$location",
	"$http",
	"$q",
	"$state",
	($location, $http, $q, $state) ->
		redirect = (url) ->
			url = url or "/"
			$location.path url
			return

		service = 
			showLogin: ->
				redirect "/login"

			hideLogin: ->
				redirect "/"

			login: (login, password) ->
				$http.post("/api/v1/doctors/sign_in.json",
					doctor:
						login: login,
						password: password
				).success((data, status, header, config) ->
					service.current_user = data.doctor
					if service.isAuthenticated() then redirect()
				).error (data, status) ->
					alert(data.message)

			signup: (params) ->
				$http.post("/api/v1/signup.json",
					user: params
				).success (data, status, header, config) ->
					service.current_user = data.user
					if service.isAuthenticated() then redirect()

			logout: (newState) ->
				$http.post("/api/v1/doctors/sign_out.json").then (response) ->
					service.current_user = null
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
				$http.get("/api/v1/doctors/current_user.json").success((data, status) ->
					service.current_user = data.doctor
					
					successCallback() if typeof successCallback is 'function'

					setTimeout ->
						floatedOptions.initialize()
					, 1
					
					return service.current_user
				).error (response) ->
					errorCallback() if typeof errorCallback is 'function'
					console.log response

			current_user: null

			isAuthenticated: ->
				!!service.current_user

		return service
]
