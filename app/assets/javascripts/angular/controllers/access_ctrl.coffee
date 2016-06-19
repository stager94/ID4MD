window.AccessCtrl = {}

AccessCtrl.checkAuth = (access) ->
	access.checkAuth false

AccessCtrl.checkAccess = (access) ->
	access.checkAuth true
