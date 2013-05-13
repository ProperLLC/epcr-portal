'use strict'

describe 'Service: Incidents', () ->

  # load the service's module
  beforeEach module 'epcrPortalApp'

  # instantiate service
  Incidents = {}
  beforeEach inject (_Incidents_) ->
    Incidents = _Incidents_

  it 'should do something', () ->
    expect(!!Incidents).toBe true;
