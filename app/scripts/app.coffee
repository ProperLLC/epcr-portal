'use strict'

angular.module('epcrPortalApp', [])
  .config(['$routeProvider', ($routeProvider) ->
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

  .run [ '$rootScope', '$location', 'UserSession', ($rootScope, $location, UserSession) ->
      $rootScope.$on "$routeChangeStart", (event, next, current) ->
        console.log "changing route from: #{current?.$$route?.templateUrl} to #{next?.$$route.templateUrl}"
        # look for logged in user...
        if not UserSession.isLoggedIn()
          $location.path "/login" unless next.$$route.templateUrl.indexOf("views/public") == 0

]