'use strict'

describe 'Service: UserSession', () ->

  # load the service's module
  beforeEach module 'epcrPortalApp'

  # instantiate service
  UserSession = {}
  beforeEach inject (_UserSession_) ->
    UserSession = _UserSession_

  it 'should do something', () ->
    expect(!!UserSession).toBe true;
