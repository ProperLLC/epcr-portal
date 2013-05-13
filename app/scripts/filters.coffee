'use strict'

angular.module('epcrPortalApp.filters', [])
  .filter('formatDate', () ->
    (dateString) ->
      if (dateString?)
        month = dateString.substring(0,2)
        day = dateString.substring(2,4)
        year = dateString.substring(4)

        result = "#{year}-#{month}-#{day}"
      else
        result = ""
  )