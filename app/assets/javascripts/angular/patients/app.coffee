#= require ./fields_storage/patients

window.App = angular.module("pdmapp", [
  "ngResource",
  "ngRoute",
  "ngSanitize",
  "security",
  "ui.router"
])

App.config ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $urlRouterProvider.otherwise '/login'
  $stateProvider.state('login',
    url: '/login',
    templateUrl: 'templates/patients/login.html',
    controller: 'HomeCtrl',
    data:
      needNoUser: true
  ).state('invitation',
    url: '/invitation/:token/:secret/accept',
    templateUrl: 'templates/patients/accept_invitation.html',
    controller: 'Patients.InvitationCtrl',
    data:
      needNoUser: true
  ).state('chat',
    url: '/dashboard/chat',
    templateUrl: 'templates/patients/dashboard/chat.html',
    controller: 'DashboardCtrl'
    data:
      needPatient: true
  ).state('appointments',
    url: '/dashboard/appointments',
    templateUrl: 'templates/patients/dashboard/appointments.html',
    controller: 'DashboardCtrl'
    data:
      needPatient: true
  ).state('diagnosises',
    url: '/dashboard/diagnosises',
    templateUrl: 'templates/patients/dashboard/diagnosises.html',
    controller: 'DashboardCtrl'
    data:
      needPatient: true
  ).state('visits',
    url: '/dashboard/visits',
    templateUrl: 'templates/patients/dashboard/visits.html',
    controller: 'DashboardCtrl'
    data:
      needPatient: true
  ).state('doctors_show',
    url: '/doctors/:id',
    templateUrl: 'templates/patients/doctors/show.html',
    controller: 'Doctors.ProfileCtrl'
    data:
      needPatient: true
  ).state('profile',
    url: '/profile',
    templateUrl: 'templates/patients/dashboard/profile.html',
    controller: 'Patients.ProfileCtrl'
    data:
      needPatient: true
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
      $rootScope.$broadcast "loaded-current-patient"
      if (to.data && to.data.needNoUser)
        setTimeout ->
          $state.go "chat"
          $("body").removeClass "hidden"
        , 1
      setTimeout ->
        $("body").removeClass "hidden"
      , 2
    error = ->
      if (to.data && to.data.needPatient)
        setTimeout ->
          $state.go "login"
        , 1
      setTimeout ->
        $("body").removeClass "hidden"
      , 2
    
    security.requestCurrentUser success, error

  $rootScope.$on '$stateChangeSuccess', (e, to) ->
    setTimeout ->
      $(document).trigger "ngready"
    , 100


App.directive 'ngBindModel', ($compile) ->
  { compile: (tEl, tAtr) ->
    tEl[0].removeAttribute 'ng-bind-model'
    (scope) ->
      tEl[0].setAttribute 'ng-model', scope.$eval(tAtr.ngBindModel)
      $compile(tEl[0]) scope
      return
 }

