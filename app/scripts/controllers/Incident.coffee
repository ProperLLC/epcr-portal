'use strict'

angular.module('epcrPortalApp')
  .controller 'IncidentCtrl', ['$scope', '$location', 'UserSession', 'Incidents', ($scope, $location, UserSession, Incidents) ->
    $scope.userSession = UserSession
    $scope.currentUser = UserSession.getCurrentUser()

    Incidents.findForOrganization($scope.currentUser.organizationCode)
          .then (incidents) ->
            $scope.incidents = incidents

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
