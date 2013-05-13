'use strict';

angular.module('epcrPortalApp')
  .factory 'Incidents', [() ->
    # Service logic
    # ...

    meaningOfLife = 42

    # Public API here
    {
      someMethod: () ->
        return meaningOfLife;
    }
  ]
