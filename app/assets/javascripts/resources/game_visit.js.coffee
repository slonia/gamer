class GameVisit
  @$inject = ['$resource']

  constructor: (@$resource) ->
    return @$resource '/game_visits/:game_id/:user_id.:format', { format: 'json' },
      set:
        method: 'GET'
        isArray: false
        cache: false

angular.module('Gamer').factory 'GameVisit', GameVisit
