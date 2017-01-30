$ ->
  $("a").bind "ajax:error", (event, jqXHR, ajaxSettings, thrownError) ->
    if jqXHR.status == 401 # thrownError is 'Unauthorized'
      window.location.replace('/login')
