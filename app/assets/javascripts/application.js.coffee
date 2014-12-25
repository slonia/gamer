#= require angular
#= require angular-ui-router.min
#= require angular-resource
#= require_self
#= require_tree ./config
#= require_tree ./controllers

dependencies = [
  'ui.router'
]
angular.module 'Gamer', dependencies
