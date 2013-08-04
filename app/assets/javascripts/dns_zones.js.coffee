# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "click", "#hide_rr_section", (event) ->
  event.preventDefault() # Prevent link from following its href
  $("#rr_section_content").toggle()
  $('#hide_rr_section').html((if ($('#hide_rr_section').html() is "Show more") then "Show less" else "Show more"))

