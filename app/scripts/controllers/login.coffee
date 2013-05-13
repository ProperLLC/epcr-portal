'use strict'

angular.module('epcrPortalApp')
  .controller 'LoginCtrl', ['$scope', '$location', 'UserSession', ($scope, $location, UserSession) ->
    $scope.login = () ->
      results = UserSession.login($scope.credentials)
      console?.log "login results", results
      results.then (results) ->
        console.log "yay - logged in!"
        $location.path '/incidents'
      , (error) ->
        console.log "ugh - failed!"
        $scope.message = "Sorry, try again!"
  ]
