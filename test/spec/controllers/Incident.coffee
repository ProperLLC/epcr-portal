'use strict'

describe 'Controller: IncidentCtrl', () ->

  # load the controller's module
  beforeEach module 'epcrPortalApp'

  IncidentCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    IncidentCtrl = $controller 'IncidentCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3;
