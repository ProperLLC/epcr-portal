'use strict'

angular.module('epcrPortalApp', ['ngRoute', 'ngResource', 'LocalStorageModule', 'hawk.auth', 'epcr.auth','epcrPortalApp.filters', 'services.envConfig'])
  .config(['$routeProvider', '$locationProvider', 'hawkServiceProvider', ($routeProvider, $locationProvider, hawkServiceProvider) ->
    # setup urls we don't need hawk auth for
    hawkServiceProvider.setWhiteList(['/ping', '/login'])

    # enable html5 navigation mode
    $locationProvider.html5Mode true
    $locationProvider.hashPrefix = '!'

    $routeProvider
      .when '/',
        templateUrl: 'views/public/main.html'
        controller: 'MainCtrl'
      .when '/login',
        templateUrl: 'views/public/login.html'
        controller: 'LoginCtrl'
      .when '/incidents',
        templateUrl: 'views/incidents.html'
        controller: 'IncidentCtrl'
        resolve :
          incidents : ($rootScope, Incidents) ->
            if ($rootScope.auth.isLoggedIn())
              Incidents.findForOrganization($rootScope.auth.getCurrentUser().organizationCode)
            else
              []

      .otherwise
        redirectTo: '/'
  ])

  .run ([ '$rootScope', 'authService', ($rootScope, authService) ->
    $rootScope.auth = authService
  ])
