#= require angular
#= require angular-ui-router.min
#= require angular-resource
#= require spin.min
#= require angular-spinner.min
#= require_self
#= require_tree ./config
#= require_tree ./controllers
#= require_tree ./directives
#= require_tree ./resources

dependencies = [
  'ngResource'
  'ui.router'
  'angularSpinner'
]
angular.module 'Gamer', dependencies
