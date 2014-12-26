class Team
  @$inject = ['$resource']

  constructor: (@$resource) ->
    return @$resource '/teams/:slug.:format', { format: 'json' }
angular.module('Gamer').factory 'Team', Team
