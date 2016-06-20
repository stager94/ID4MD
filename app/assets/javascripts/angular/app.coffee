#= require ./fields_storage/patients

window.App = angular.module("pdmapp", [
  "ngResource",
  "ngRoute",
  "ngSanitize",
  "security",
  "access",
  "ui.router"
])

App.config ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $urlRouterProvider.otherwise '/profile'
  $stateProvider.state('profile',
    url: '/profile',
    templateUrl: '/templates/doctors/profile.html',
    controller: 'Doctors.ProfileCtrl',
    data:
      needDoctor: true
  ).state('login',
    url: '/login',
    templateUrl: 'templates/doctors/login.html',
    controller: 'HomeCtrl',
    data:
      needNoUser: true
  ).state('patients_new',
    url: '/patients/new',
    templateUrl: 'templates/doctors/patients/new.html',
    controller: 'Doctors.PatientsInvitationCtrl',
    data:
      needDoctor: true
  ).state('patients_show',
    url: '/patients/:id',
    templateUrl: 'templates/doctors/patients/show.html',
    controller: 'Doctors.PatientsCtrl',
    data:
      needDoctor: true
  ).state('patients_chat',
    url: '/patients/:id/chat',
    templateUrl: 'templates/doctors/patients/chat.html',
    controller: 'Doctors.PatientsCtrl'
    data:
      needDoctor: true
  ).state('patients_appointments',
    url: '/patients/:id/appointments',
    templateUrl: 'templates/doctors/patients/appointments.html',
    controller: 'Doctors.PatientsCtrl'
    data:
      needDoctor: true
  ).state('patients_diagnosises',
    url: '/patients/:id/diagnosises',
    templateUrl: 'templates/doctors/patients/diagnosises.html',
    controller: 'Doctors.PatientsCtrl'
    data:
      needDoctor: true
  ).state('patients_visits',
    url: '/patients/:id/visits',
    templateUrl: 'templates/doctors/patients/visits.html',
    controller: 'Doctors.PatientsCtrl'
    data:
      needDoctor: true
  )

  $locationProvider.html5Mode
    enabled: false
    requireBase: false


App.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = document.getElementsByName("csrf-token")[0].content
  $httpProvider.defaults.headers.common['Accept'] = "application/json"
]

angular.module("pdmapp").run (security, $rootScope, $state) ->
  # Get the current user when the application starts
  # (in case they are still logged in from a previous session)

  # TODO: 
  # 1) Make API request for fetching current_user
  # 2) Show APP loader
  # 

  us = security.requestCurrentUser()
  $rootScope.$on '$stateChangeStart', (e, to) ->
    setTimeout ->
      reloadFunction()
      if (to.data && to.data.needDoctor && !security.isAuthenticated())
        e.preventDefault()
        $state.go "login"
      if (to.data && to.data.needNoUser && security.isAuthenticated())
        e.preventDefault()
        $state.go "profile"
    , 100

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

