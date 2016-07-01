App.controller('ChatCtrl', ['$scope', '$rootScope', '$state', '$http', ($scope, $rootScope, security, $state, $http) ->
	setTimeout ->
		$('.scrollable').animate({ scrollTop: 9999 }, 0)
	, 100
])
