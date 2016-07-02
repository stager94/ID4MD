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


