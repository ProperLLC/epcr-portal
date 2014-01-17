class AuthService
  constructor: (@$q, @$rootScope, @$http, @config, @localStorageService, @Users) ->

  login : (user) ->
    console.log "Attempting auth for #{user.email}"
    # let's clear out any old credentials
    @localStorageService.clearAll()
    # Base64 encode the user/pass for the Authorization header
    encodedCredentials = CryptoJS.enc.Base64.stringify(CryptoJS.enc.Utf8.parse("#{user.email}:#{user.password}"))
    # build the header
    httpConfig =
      headers :
        Authorization : " Basic #{encodedCredentials}"

    apiHost = "#{@config.api.protocol}://#{@config.api.host}:#{@config.api.port}"

    url = "#{apiHost}/login"

    @$http.get(url, httpConfig)
    .success (data, status, headers, config) =>
        @localStorageService.add('credentials', data)
        @$rootScope.$broadcast 'auth:login:success'
        @Users.get(data.email)
          .then (user) =>
            console.log "current user -> ", user
            @localStorageService.add('userContext', user)

    .error (data, status, headers, config) =>
        console.log "Error attempting to auth #{status}", data
        @$rootScope.$broadcast('auth:login:failed')

  logout : ->
    # TODO - invoke logout on server
    @localStorageService.clearAll()
    @$rootScope.$broadcast 'auth:logout:success'

  getCurrentUser : ->
    @localStorageService.get('userContext')

  isLoggedIn : ->
    @localStorageService.get('credentials')?

  isSuperAdmin : ->


class HttpBuffer
  constructor : (@$http) ->
    @buffer = []

    @retryHttpRequest = (bufferedRequest) ->
      success = (data) ->
        console.log "call back response: ", response, bufferedRequest.deferred
        # rebuild as expected for angular to work
        response =
          data : data
          status : 200
          headers : null
          config : null
        bufferedRequest.deferred.resolve(response)

      error = (response) ->
        bufferedRequest.deferred.reject(response)

      $http(bufferedRequest.config).then(success, error)

  append : (config, deferred) =>
    @buffer.push { config : config, deferred : deferred}

  retryAll : () =>
    retryHttpRequest(request) for request in @buffer
    @buffer = []

angular.module('epcr.auth', ['LocalStorageModule', 'services.envConfig'])
.service('authService', ['$q', '$rootScope','$http', 'config', 'localStorageService', 'Users', AuthService])
.service('httpBuffer', ['$http', HttpBuffer])