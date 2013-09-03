# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).on "change", "[data-purpose=\"show-types\"]", (e) ->

  if ($("[data-purpose=\"show-types\"]").val() is "MX")
    $(".rr_option").css "display", "block"
    $(".rr_name").css "display", "none"
  else
    $(".rr_option").css "display", "none"
    $(".rr_name").css "display", "block"

  if ($("[data-purpose=\"show-types\"]").val() is "NS")
    $(".rr_name").css "display", "none"
  else
    $(".rr_name").css "display", "block"

hide = ->
  $(document).on "click", "#hide_rr_section", (event) ->
    event.preventDefault() # Prevent link from following its href
    $(".rr_section_form").toggle()
    $('#hide_rr_section').html((if ($('#hide_rr_section').html() is "Show more") then "Show less" else "Show more"))

$(document).ready(hide)
$(document).on('page:load', hide)
