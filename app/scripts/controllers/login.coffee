'use strict'

angular.module('epcrPortalApp')
  .controller 'LoginCtrl', ['$scope', '$location', 'UserSession', ($scope, $location, UserSession) ->
    $scope.userSession = UserSession

    $scope.login = () ->
      results = UserSession.login($scope.credentials)
      results.then (user) ->
        console.log "yay - logged in!"
        $location.path '/incidents'
      , (error) ->
        console.log "ugh - failed! #{error}"
        $scope.message = "Sorry, try again!"
  ]
