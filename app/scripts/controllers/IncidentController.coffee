'use strict'

angular.module('epcrPortalApp')
  .controller 'IncidentCtrl', ['$scope', 'incidents', ($scope, incidents) ->
    console.log "IncidentCtrl: incidents -> ", incidents
    $scope.incidents = incidents
  ]
