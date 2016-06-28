#= require ./fields_storage/patients

window.App = angular.module("pdmapp", [
  "ngResource",
  "ngRoute",
  "ngSanitize",
  "security",
  "ui.router"
])

App.config ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $urlRouterProvider.otherwise '/dashboard'
  $stateProvider.state('login',
    url: '/login',
    templateUrl: 'templates/patients/login.html',
    controller: 'HomeCtrl',
    data:
      needNoUser: true
  )

  $locationProvider.html5Mode
    enabled: false
    requireBase: false


App.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = document.getElementsByName("csrf-token")[0].content
  $httpProvider.defaults.headers.common['Accept'] = "application/json"
]

angular.module("pdmapp").run (security, $rootScope, $state) ->

  $rootScope.$on '$stateChangeStart', (e, to) ->
    success = ->
      if (to.data && to.data.needNoUser)
        setTimeout ->
          $state.go "dashboard"
        , 1
    error = ->
      if (to.data && to.data.needDoctor)
        setTimeout ->
          $state.go "login"
        , 1
    
    security.requestCurrentUser success, error

  $rootScope.$on '$stateChangeSuccess', (e, to) ->
    setTimeout ->
      $(document).trigger "ngready"
    , 1


App.directive 'ngBindModel', ($compile) ->
  { compile: (tEl, tAtr) ->
    tEl[0].removeAttribute 'ng-bind-model'
    (scope) ->
      tEl[0].setAttribute 'ng-model', scope.$eval(tAtr.ngBindModel)
      $compile(tEl[0]) scope
      return
 }

