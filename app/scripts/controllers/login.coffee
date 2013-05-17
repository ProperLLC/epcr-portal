'use strict'

angular.module('epcrPortalApp')
  .controller 'LoginCtrl', ['$scope', '$location', 'UserSession', ($scope, $location, UserSession) ->
    $scope.userSession = UserSession

    $scope.cancel = () ->
      $location.path '/'

    $scope.login = () ->
      UserSession.login($scope.credentials)
        .then (results) ->
          console.log "Logged In =>", results
          $location.path '/incidents'
        , (error) ->
            console.log "ugh - failed! #{error}"
            $scope.message = "Sorry, try again!"
  ]
