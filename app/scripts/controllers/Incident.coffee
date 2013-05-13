'use strict'

angular.module('epcrPortalApp')
  .controller 'IncidentCtrl', ['$scope', '$location', 'UserSession', ($scope, $location, UserSession) ->
    $scope.logout = () ->
      results = UserSession.logout()
      console?.log "logout results", results
      results.then (results) ->
        console.log "yay - logged out!"
        $location.path '/main'
      , (error) ->
        console.log "ugh - failed!"
        $scope.message = "Sorry, try again!"

  ]