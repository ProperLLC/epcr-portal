'use strict'

angular.module('epcrPortalApp')
  .controller 'LoginCtrl', ['$scope', '$location', 'UserSession', ($scope, $location, UserSession) ->
    $scope.userSession = UserSession

    $scope.cancel = () ->
      $location.path '/'

    $scope.login = () ->
      results = UserSession.login($scope.credentials)
      console.log "yay - logged in!", results
      #results.then (user) ->
      $location.path '/incidents'
      #, (error) ->
      #  console.log "ugh - failed! #{error}"
      #  $scope.message = "Sorry, try again!"
  ]
