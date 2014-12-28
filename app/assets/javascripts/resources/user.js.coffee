class User
  @$inject = ['$resource']

  constructor: (@$resource) ->
    return @$resource '/profile.:format', { format: 'json' }
angular.module('Gamer').factory 'User', User
