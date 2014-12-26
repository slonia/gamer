class ScrollAction
  @$inject = ['$window', '$document']
  constructor: (@$window, @$document) -> return {
    link: ScrollAction.link
  }

  @link: (scope, element, attrs) ->
    $document.bind 'scroll', ->
      el = element[0]
      if ($window.scrollY >= el.offsetHeight - $window.innerHeight - 150) && (scope.scrollable)
        scope.$apply scope[attrs['scrollAction']]

angular.module('Gamer').directive 'scrollAction', ScrollAction
