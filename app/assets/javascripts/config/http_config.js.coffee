class HttpConfig
  CSRF_TOKEN = document.querySelector('meta[name="csrf-token"]').content
  @$inject = ['$httpProvider']

  constructor: (@$httpProvider) ->
    angular.extend @$httpProvider.defaults.headers.common, HttpConfig.common_headers

  @common_headers:
    'X-Requested-With': 'XMLHttpRequest'
    'X-CSRF-TOKEN': CSRF_TOKEN

angular.module('Gamer').config HttpConfig
