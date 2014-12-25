class TeamsController
  @$inject = ['$scope']

  constructor: (@$scope) ->
    debugger
    console.log('ok')

angular.module('Gamer').controller 'TeamsController', TeamsController
