'use strict';

angular.module('epcrPortalApp')
  .factory 'Incidents', ['$http', '$q', '$rootScope', 'UserSession', ($http, $q, $rootScope, UserSession) ->
    # Service logic
    # ...

    # Public API here
    {
      findForOrganization: (orgCode) ->
        deferred = $q.defer()

        query = undefined
        if (orgCode != "PROPERLLC")
          query =
            departmentCode : orgCode
            $or :
              hospitalCode : orgCode

        filter =
          'formData.incidentdate' : 1
          'formData.patientage' : 1
          'formData.patientgender_m' : 1
          'formData.patientgnder_f' : 1
          'formData.complaint.chief1' : 1
          'formData.moi.chief1' : 1
          'formData.protocol' : 1
          'sequenceId' : 1

        url = if (query?) then "http://localhost:9000/data/incidents?query=#{JSON.stringify(query)}&filter=#{JSON.stringify(filter)}&sort=-formData.incidentDate" else "http://localhost:9000/data/incidents?filter=#{JSON.stringify(filter)}&sort=-formData.incidentDate"

        $rootScope.error = ""
        $http.get(url, UserSession.getAuthHeader())
          .success (data, status, headers, config) ->
            if status == 200
              console.log "Found -> ", data
              deferred.resolve(data)
            else
              console.log "Didn't find any incidents for #{orgCode}, Status: #{status}, Message: #{data.error}"
              deferred.resolve(data)

          .error (data, status, headers, config) ->
            console.log "Error on Incidents.findForOrganization request #{data} : #{status} : #{headers}, #{config}", headers, config
            $rootScope.error = "No Incidents on record for your organization."

        deferred.promise

    }
  ]
