'use strict';
angular.module('epcr.services', [])

angular.module('epcr.services')
  .factory 'Users', ['$http', '$q', 'config', '$rootScope', ($http, $q, config, $rootScope) ->
    # Service logic
    # ...
    apiHost = "#{config.api.protocol}://#{config.api.host}:#{config.api.port}"

    # Public API here
    {
      get : (email) ->
        console.log "looking up record for #{email}", email
        deferred = $q.defer()
        $rootScope.error = ""

        query =
          email : "#{email}"

        filter =
          _id : 0
          password : 0

        # NOTE - put these in alpha order so the Hawk message is generated properly on both sides
        httpConfig =
          params :
            filter: encodeURIComponent(JSON.stringify(filter))
            query: encodeURIComponent(JSON.stringify(query))

        $http.get("#{apiHost}/data/users", httpConfig)
          .success (data, status, headers, config) ->
            if status == 200
              console.log "Found User -> ", data[0]
              deferred.resolve(data[0])
            else
              console.log "Didn't find the user #{email}, Status: #{status}, Message: #{data.error}"
              deferred.reject(data)

          .error (data, status, headers, config) ->
            console.log "Error on Users.findByUsername request : #{status}", data, headers(), config
            $rootScope.error = "Could not find user in database - are you for real?"
            deferred.reject(data)

        deferred.promise


    }
  ]
