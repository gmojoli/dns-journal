# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "change", "[data-purpose='show-types']", (e) ->
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

hide = (event)->
  event.preventDefault() # Prevent link from following its href
  $(".rr_section_form").toggle()
  $('#hide_rr_section').html((if ($('#hide_rr_section').html() is "Show more") then "Show less" else "Show more"))

$(document).on 'ready page:load', ->
  $(document).on 'click', '#hide_rr_section', hide

$(document).on "change", "[data-purpose='show-types']", (e) ->
  console.log $("[data-purpose='show-types']").val()
  $.ajax("/resource_record_description/" + $("[data-purpose='show-types']").val()).done (response) ->
    console.log "the response is: " + response
    $('.panel').first().html(response.join(', '))

# # routes.rb
# resources :users do
#   get :render_read, on: :collection
#   # or you may prefer to call this route on: :member
# end

# # users_controller.rb
# def render_read
#   @current_user.render_read
#   # I made this part up, do whatever necessary to find the needed user here
# end
