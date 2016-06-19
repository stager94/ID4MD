angular.module "access", ["access.service"]

angular.module("access.service", []).factory "access", ($http, $location, $q, $state, tokenHandler) ->
		service =
			checkAuth: (signed) ->
				defered = $q.defer()
				$http.get("/api/v1/doctors/current_user.json").success((response) ->
					console.log response.success, signed
					if (response.success && signed == true) || (!response.success && signed == false)
						defered.resolve response
					else
						defered.reject()
						$location.path("/").replace()
					return
				).error ->
					defered.reject()
					$location.path("/").replace()
					return
				defered.promise

		return service
