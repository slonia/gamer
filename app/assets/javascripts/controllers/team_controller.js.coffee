class TeamController
  @$inject = ['$scope']

  constructor: (@$scope) ->
    console.log('ok2')

angular.module('Gamer').controller 'TeamController', TeamController
