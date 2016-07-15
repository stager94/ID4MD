#= require ./fields_storage/patients

window.App = angular.module("pdmapp", [
  "ngResource",
  "ngRoute",
  "ngSanitize",
  "security",
  "ui.router",
  "simpleFormat",
  "angular.filter"
])

App.config ['$stateProvider', '$urlRouterProvider', '$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $urlRouterProvider.otherwise '/dashboard'
  $stateProvider.state('login',
    url: '/login',
    templateUrl: 'templates/doctors/login.html',
    controller: 'HomeCtrl',
    data:
      needNoUser: true
  ).state('profile',
    url: '/profile',
    templateUrl: '/templates/doctors/profile.html',
    controller: 'Doctors.ProfileCtrl',
    data:
      needDoctor: true
  ).state('dashboard',
    url: '/dashboard',
    templateUrl: '/templates/doctors/dashboard.html',
    controller: 'Doctors.DashboardCtrl',
    data:
      needDoctor: true
  ).state('availability',
    url: '/availability',
    templateUrl: 'templates/doctors/availability.html',
    controller: 'Doctors.AvailabilityCtrl',
    data:
      needDoctor: true
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
]

App.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = document.getElementsByName("csrf-token")[0].content
  $httpProvider.defaults.headers.common['Accept'] = "application/json"
]

angular.module("pdmapp").run ['security', '$rootScope', '$state', (security, $rootScope, $state) ->

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
]

angular.module("pdmapp").directive 'whenScrolled', [
  '$timeout'
  ($timeout) ->
    (scope, elm, attr) ->
      raw = elm[0]
      $timeout ->
        raw.scrollTop = raw.scrollHeight
        return
      elm.bind 'scroll', ->
        if raw.scrollTop <= 50
          # load more items before you hit the top
          sh = raw.scrollHeight
          scope.$apply attr.whenScrolled
          raw.scrollTop = raw.scrollHeight - sh
        return
      return
]
