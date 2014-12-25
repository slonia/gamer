class RouteConfig
  @$inject = ['$stateProvider', '$locationProvider']

  constructor: (@$stateProvider, @$locationProvider) ->
    @$locationProvider.html5Mode
      enabled: true
      requireBase: false

    @$stateProvider
      .state('teams', url: '/', controller: 'TeamsController', templateUrl: "/teams.html" )
      .state('team', url: '/teams/:slug', controller: 'TeamController', templateUrl: '/team.html')

angular.module('Gamer').config RouteConfig
