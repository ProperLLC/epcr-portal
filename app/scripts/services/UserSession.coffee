'use strict';

angular.module('epcrPortalApp')
  .factory 'UserSession', ['$rootScope', '$http', '$q', ($rootScope, $http, $q) ->
    # Service logic
    # ...

    sessionId = undefined

    # Public API here
    {
      someMethod: () ->
        meaningOfLife;

      isLoggedIn : () ->
        sessionId?

      login : (credentials) ->
        deferred = $q.defer

        $http.post("http://localhost:9000/login", credentials)
          .success (data, status, headers, config) ->
            if status == 200
              console.log "Successful login", data
              sessionId = data
              deferred.resolve(data)
              deffered.promise
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

    }
  ]
