class TeamsController
  @$inject = ['$scope', 'Team']

  constructor: (@$scope, @Team) ->
    @$scope.teams = @Team.query()

angular.module('Gamer').controller 'TeamsController', TeamsController
