App.controller('ApplicationCtrl', ['$scope', '$rootScope', 'security', '$state', ($scope, $rootScope, security, $state) ->
	moment.locale 'ru'
	$scope.security = security
	$scope.user = {}
	$scope.showOverlay = false
	$scope.activeContextMenu = ''

	$scope.logout = ->
		security.logout()
		$state.go "login"

	$scope.login = ->
		console.log "login"
		security.login $scope.user.login, $scope.user.password

	$rootScope.openSidebar = ->
		$("#sidebar").show()
		$(".content").hide()
		$(".fixed-header").hide()
		setTimeout ->
			Page.onResize()
		, 1
		return

	$scope.hideSidebar = ->
		$("#sidebar").hide()
		$(".content").show()
		$(".fixed-header").show()
		setTimeout ->
			Page.onResize()
		, 1
		return

	$scope.hideContextMenu = ->
		$scope.showOverlay = false
		$scope.activeContextMenu = ''
	$scope.showContextMenu = ->
		$scope.showOverlay = true
	$scope.openContextMenu = (title) ->
		$scope.activeContextMenu = title
		$scope.showContextMenu()

	$rootScope.$on "loaded-current-patient", (event, data) ->
		setTimeout ->
			Page.onResize()
		, 1
])
