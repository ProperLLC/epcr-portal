'use strict';

angular.module('epcrPortalApp')
  .factory 'Incidents', ['$http', '$q', '$rootScope', 'config', ($http, $q, $rootScope, config) ->
    # Service logic
    # ...
    apiHost = "#{config.api.protocol}://#{config.api.host}:#{config.api.port}"

    # Public API here
    {
      findForOrganization: (orgCode) ->
        deferred = $q.defer()

        query = undefined
        if (orgCode != "PROPERLLC")
          query =
            $or : [
              {
                departmentCode : orgCode
              },
              {
                hospitalCode : orgCode
              }
            ]

        filter =
          'formData.incidentdate' : 1
          'formData.patientage' : 1
          'formData.patientgender_m' : 1
          'formData.patientgnder_f' : 1
          'formData.complaint.chief1' : 1
          'formData.moi.chief1' : 1
          'formData.protocol' : 1
          'sequenceId' : 1,
          'departmentCode' : 1,
          'hospitalCode' : 1

        httpConfig =
          params:
            filter : encodeURIComponent(JSON.stringify(filter))
            query : encodeURIComponent(JSON.stringify(query))
            sort : "-formData.incidentdate"

        if (not query?)
          delete httpConfig.params.query
        #url = if (query?) then "#{apiHost}/data/incidents" else "http://localhost:9000/data/incidents?filter=#{JSON.stringify(filter)}&sort=-formData.incidentDate"

        $rootScope.error = ""
        $http.get("#{apiHost}/data/incidents", httpConfig)
          .success (data, status, headers, config) ->
            if status == 200
              console.log "Found -> ", data
              deferred.resolve(data)
            else
              console.log "Didn't find any incidents for #{orgCode}, Status: #{status}, Message: #{data.error}"
              deferred.reject(data)

          .error (data, status, headers, config) ->
            console.log "Error on Incidents.findForOrganization request #{data} : #{status} : #{headers}, #{config}", headers, config
            $rootScope.error = "No Incidents on record for your organization."
            deferred.reject(data)

        deferred.promise

    }
  ]
