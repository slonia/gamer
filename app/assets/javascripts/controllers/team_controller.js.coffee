class TeamController
  @$inject = ['$scope', '$stateParams', 'usSpinnerService', 'Team', 'GameVisit']

  OPTIONS = [
    value: 'visited'
    text: 'Буду'
  ,
    value: 'not_visited'
    text: 'Не буду'
  ,
    value: 'unknown'
    text: 'Неизвестно'
  ]

  constructor: (@$scope, @$stateParams, @usSpinnerService, @Team, @GameVisit) ->
    @$scope.games = []
    @$scope.users = []
    @$scope.current_user = null
    @$scope.status_options = OPTIONS
    @$scope.load_games = @load_games
    @$scope.set_game_visit = @set_game_visit
    @$scope.translate = @translate
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
          @$scope.current_user = data.current_user
          @usSpinnerService.stop('games_init')
        else
          Array::push.apply @$scope.games, data.games
        @$scope.current_page = page
        @$scope.scrollable = true

  set_game_visit: (game_id, status) =>
    @GameVisit.set(game_id: game_id, status: status)

  translate: (status = 'unknown') =>
    for option in OPTIONS
      if option.value == status
        return option.text
angular.module('Gamer').controller 'TeamController', TeamController
