# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

rr_fields_display = ()->
  if ($("[data-purpose='show-types']").val() is "MX")
    $(".rr_option").css "display", "block"
    $(".rr_name").css "display", "none"
  else
    $(".rr_option").css "display", "none"
    $(".rr_name").css "display", "block"

  if ($("[data-purpose='show-types']").val() is "NS")
    $(".rr_name").css "display", "none"
  else
    $(".rr_name").css "display", "block"

$(document).on "change", "[data-purpose='show-types']", (e) ->
  return rr_fields_display()

$(document).on 'ready page:load', (e)->
  return rr_fields_display()

$(document).on "change", "[data-purpose='show-types']", (e) ->
  $.ajax("/resource_record_description/" + $("[data-purpose='show-types']").val()).done (response) ->
    $('.rr_description_panel').first().empty()
    $(response).each (index) ->
      $('<p>', {
       class: '',
       text: response[index],
      }).appendTo($('.rr_description_panel').first())
  return
