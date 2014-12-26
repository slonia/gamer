class TeamController
  @$inject = ['$scope', '$stateParams', 'Team']

  constructor: (@$scope, @$stateParams, @Team) ->
    @$scope.games = []
    @$scope.users = []
    @$scope.load_games = @load_games
    @$scope.scrollable = true
    @load_games()

  load_games: () =>
    @$scope.scrollable = false
    page = if @$scope.current_page then @$scope.current_page + 1 else 1
    if page == 1 || page <= @$scope.max_pages
      @Team.get({slug: @$stateParams.slug, page: page}).$promise.then (data) =>
        if page == 1
          @$scope.games = data.games
          @$scope.users = data.users
          @$scope.max_pages = data.max_pages
        else
          Array::push.apply @$scope.games, data.games
        @$scope.current_page = page
        @$scope.scrollable = true

angular.module('Gamer').controller 'TeamController', TeamController
