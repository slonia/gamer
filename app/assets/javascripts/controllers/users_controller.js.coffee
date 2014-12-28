class UsersController
  @$inject = ['$scope', 'User']

  constructor: (@$scope, @User) ->
    @$scope.user = @User.get()

angular.module('Gamer').controller 'UsersController', UsersController
