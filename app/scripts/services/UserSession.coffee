'use strict';

angular.module('epcrPortalApp')
  .factory 'UserSession', ['$rootScope', '$http', '$q', ($rootScope, $http, $q) ->
    # Service logic
    # ...

    session = undefined
    deferredUser = undefined
    currentUser = undefined

    # Public API here
    {

      isLoggedIn : () ->
        session?

      getDeferredUser : () ->
        deferredUser

      getCurrentUser : () ->
        console.log "current user ->", currentUser
        currentUser

      findUser : (username) ->
        deferred = $q.defer()
        $rootScope.error = ""
        config =
          headers :
            Authorization : " Bearer #{session?.auth_token}"

        query =
          username : "#{username}"

        filter =
          _id : 0
          password : 0

        $http.get("http://localhost:9000/data/users?query=#{JSON.stringify(query)}&filter=#{JSON.stringify(filter)}", config)
          .success (data, status, headers, config) ->
            if status == 200
              console.log "Found -> ", data[0]
              deferred.resolve(data[0])
            else
              console.log "Didn't find the user #{username}, Status: #{status}, Message: #{data.error}"
              deferred.resolve(data)

          .error (data, status, headers, config) ->
            console.log "Error on Users.findByUsername request #{data} : #{status} : #{headers}, #{config}", headers, config
            $rootScope.error = "Could not find user in database - are you for real?"

        deferred.promise

      login : (credentials) ->
        deferred = $q.defer()
        $rootScope.error = ""
        getCurrentUser = @findUser

        $http.post("http://localhost:9000/login", credentials)
          .success (data, status, headers, config) ->
            if status == 200
              console.log "Successful login", data
              session = data
              deferredUser = getCurrentUser(credentials.username)
              deferredUser.then (user) ->
                console.log("I think this is the user ->", user)
                currentUser = user
              deferred.resolve(currentUser)
            else if status == 401
              console.log "Looks like login failed #{status}", data
              deferred.reject(data)
            else
              console.log "Something went wrong... #{status}", data
              deferred.reject(data)

          .error (data, status, headers, config) ->
            console.log "Error on login request #{data} : #{status} : #{headers}, #{config}", headers, config
            $rootScope.error = "Login Error - cannot connect to host!"

        deferred.promise

      logout : () ->
        deferred = $q.defer()

        config = headers :
          Authorization : " Bearer #{session?.auth_token}"

        $http.get("http://localhost:9000/logout", config)
          .success (data, status, headers, config) ->
            console.log "Successful logout...clearing session state."
            session = undefined
            currentUser = undefined
            deferredUser = undefined
            deferred.resolve(true)
          .error (data, status, headers, config) ->
            console.log "Logout failed: #{status}, #{data}", data
            deferred.resolve(false)

        deferred.promise

    }
  ]
