class RouteConfig
  @$inject = ['$stateProvider', '$locationProvider']

  constructor: (@$stateProvider, @$locationProvider) ->
    @$locationProvider.html5Mode
      enabled: true
      requireBase: false

    @$stateProvider
      .state('dashboard', url: '/', controller: 'DashboardController', templateUrl: "/dashboard.html" )
      .state('team', url: '/teams/:slug', controller: 'TeamController', templateUrl: '/team.html')
      .state('profile', url: '/profile', controller: 'UsersController', templateUrl: '/profile.html')
angular.module('Gamer').config RouteConfig
