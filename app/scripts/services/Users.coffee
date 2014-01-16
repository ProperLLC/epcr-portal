'use strict';

angular.module('epcrPortalApp')
  .factory 'Users', ['$http', '$q', 'configuration', ($http, $q, configuration) ->
    # Service logic
    # ...
    apiHost = "#{configuration.api.protocol}://#{configuration.api.host}:#{configuration.api.port}"

    # Public API here
    {
      get : (email) ->
        deferred = $q.defer()
        $rootScope.error = ""

        query =
          username : "#{email}"

        filter =
          _id : 0
          password : 0

        $http.get("#{apiHost}/data/users?query=#{JSON.stringify(query)}&filter=#{JSON.stringify(filter)}")
          .success (data, status, headers, config) ->
            if status == 200
              console.log "Found User -> ", data[0]
              deferred.resolve(data[0])
            else
              console.log "Didn't find the user #{email}, Status: #{status}, Message: #{data.error}"
              deferred.reject(data)

          .error (data, status, headers, config) ->
            console.log "Error on Users.findByUsername request #{data} : #{status} : #{headers}, #{config}", headers, config
            $rootScope.error = "Could not find user in database - are you for real?"
            deferred.reject(data)

        deferred.promise


    }
  ]
