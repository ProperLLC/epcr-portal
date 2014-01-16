class AuthController
  constructor : (@$scope, @httpBuffer) ->
    signInShown = false

    $scope.$on('auth:required',
      (event) ->
        console.log "Need a login!"
        showSignIn()
    )

    # on failed login, redisplay the modal
    $scope.$on('auth:login:failed',
      (event) ->
        console.log "Login Failed!"
    )

    # in case there are multiple requests running, this will be fired first, if the user session was active
    # at the time of the 401.  It simply logs the user out.  If there is a second item, they'll be shown
    # the above auth:required handler which will give them the message/form to login.
    $scope.$on('auth:credentials:expired',
      (event) ->
        console.log "Credentials expired!"
        $scope.auth.logout()
        showSignIn()
    )

    $scope.$on('auth:login:success',
      (event) ->
        console.log "Login successful!"
        httpBuffer.retryAll()
        dismissSignIn()
    )

    # do we also want to handle 'auth:logout:success' ??

    # helper methods
    showSignIn = () ->
      if (!signInShown)
        $('#signInModal').modal 'show'
        signInShown = true

    dismissSignIn = () ->
      if (signInShown)
        $('#signInModal').modal 'hide'
        signInShown = false

    # expose showSignIn to UI
    $scope.showSignIn = showSignIn
    $scope.currentUser = $scope.auth.getCurrentUser()

angular.module('epcrPortalApp').controller 'AuthCtrl', ['$scope', 'httpBuffer', AuthController]