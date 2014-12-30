class Dashboard
  @$inject = ['$resource']

  constructor: (@$resource) ->
    return @$resource '/dashboard/index.:format', { format: 'json' },
      index:
        method: 'GET'
        isArray: false
        cache: false

angular.module('Gamer').factory 'Dashboard', Dashboard
