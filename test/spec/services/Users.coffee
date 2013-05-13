'use strict'

describe 'Service: Users', () ->

  # load the service's module
  beforeEach module 'epcrPortalApp'

  # instantiate service
  Users = {}
  beforeEach inject (_Users_) ->
    Users = _Users_

  it 'should do something', () ->
    expect(!!Users).toBe true;
