hide = (event, css_class)->
  event.preventDefault() # Prevent link from following its href
  $(css_class).toggle()
  # $('#hide_rr_section').html((if ($('#hide_rr_section').html() is "Show more") then "Show less" else "Show more"))

$(document).on 'click', '.wanna_change_password', (event)->
  console.log event
  $('.show_change_password').toggle()
