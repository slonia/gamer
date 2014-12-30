class UsersController
  @$inject = ['$scope', 'User']

  constructor: (@$scope, @User) ->
    @$scope.user = @User.get()
    @$scope.connected_to = @connected_to

  connected_to: (net) =>
    @$scope.user.identities && (net in @$scope.user.identities)
angular.module('Gamer').controller 'UsersController', UsersController
