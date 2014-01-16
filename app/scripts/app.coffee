'use strict'

angular.module('epcrPortalApp', ['ngRoute', 'ngResource', 'LocalStorageModule', 'hawk.auth', 'epcr.auth','epcrPortalApp.filters', 'services.envConfig'])
  .config(['$routeProvider', 'hawkServiceProvider', ($routeProvider, hawkServiceProvider) ->
    # setup urls we don't need hawk auth for
    hawkServiceProvider.setWhiteList(['/ping', '/login'])

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
      .otherwise
        redirectTo: '/'
  ])

  .run ([ '$rootScope', 'authService', ($rootScope, authService) ->
    $rootScope.auth = authService
  ])
