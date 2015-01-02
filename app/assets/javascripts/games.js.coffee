$(document).ready ->
  if $("#tblbody").length
    $(document).bind 'scroll', ->
      elem = $('#tblbody')
      current_page = elem.data('current_page')
      max_pages = elem.data('max_pages')
      new_page = current_page + 1
      updating = elem.data('updating')
      if ($(window).scrollTop() >= $(document).height() - $(window).height() - 150) && (new_page <= max_pages) && !updating
        elem.data('updating', true)
        $.ajax
          url: null
          data:
            page: new_page
          success: (data) ->
            elem.append(data)
            elem.data('current_page', new_page)
            elem.removeData('updating')
