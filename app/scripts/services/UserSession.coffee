'use strict';

angular.module('epcrPortalApp')
  .factory 'UserSession', ['$rootScope', '$http', '$q', ($rootScope, $http, $q) ->
    # Service logic
    # ...

    session = undefined
    username = undefined

    # Public API here
    {
      someMethod: () ->
        meaningOfLife;

      isLoggedIn : () ->
        session?

      login : (credentials) ->
        deferred = $q.defer()
        $rootScope.error = ""

        $http.post("http://localhost:9000/login", credentials)
          .success (data, status, headers, config) ->
            if status == 200
              console.log "Successful login", data
              session = data
              username = credentials.username
              deferred.resolve(data)
              deferred.promise
            else if status == 401
              console.log "Looks like login failed #{status}", data
              deferred.reject(data)
              deferred.promise
            else
              console.log "Something went wrong... #{status}", data
              deferred.reject(data)
              deferred.promise

          .error (data, status, headers, config) ->
            console.log "Error on login request #{data} : #{status} : #{headers}, #{config}", headers, config
            $rootScope.error = "Login Error - cannot connect to host!"

      logout : () ->
        deferred = $q.defer()
        config =
           headers :
              Authorization : " Bearer #{session.auth_token}"

        $http.get("http://localhost:9000/logout", config)
          .success (data, status, headers, config) ->
            console.log "Successful logout...clearing session state."
            session = undefined
            username = undefined
            deferred.resolve(true)
            deferred.promise
          .error (data, status, headers, config) ->
            console.log "Logout failed: #{status}, #{data}", data
            deferred.resolve(false)
            deferred.promise

    }
  ]
