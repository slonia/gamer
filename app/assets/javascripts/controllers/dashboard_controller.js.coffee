class DashboardController
  @$inject = ['$scope', 'Dashboard']

  constructor: (@$scope, @Dashboard) ->
    @Dashboard.index().$promise.then (data) =>
      @$scope.teams = data.teams
      @$scope.users = data.users
      @$scope.games = data.games

angular.module('Gamer').controller 'DashboardController', DashboardController
