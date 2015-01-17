$(document).ready ->
  $('.weekly-reminder').on 'change', ->
    url = '/users/' + $(@).attr('id') + '/weekly_toggle'
    elem = $(@)
    $.getJSON url, {}, (data) ->
      $(@).attr('checked', data.status)

