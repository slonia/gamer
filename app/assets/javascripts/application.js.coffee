#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require games
#= require profile
#= require moment
#= require moment/ru
#= require bootstrap-datetimepicker
#= require_self

$(document).on 'ready page:change', ->
  $('.datetimepicker').datetimepicker
    pickTime: true
    sideBySide: true
    locale: 'ru'

  $('.datetime_picker').on 'click', ->
    $(@).siblings('.input-group-btn').children('button').click()
