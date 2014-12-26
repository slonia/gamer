#= require angular
#= require angular-ui-router.min
#= require angular-resource
#= require_self
#= require_tree ./config
#= require_tree ./controllers
#= require_tree ./resources

dependencies = [
  'ngResource'
  'ui.router'
]
angular.module 'Gamer', dependencies
