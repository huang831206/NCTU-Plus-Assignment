# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.show_msg = false
$(window).load ->
  if not window.show_msg and typeof window.chat is "object"
    console.log "WINDOW MSG"
    window.show_msg = true
    # show connect again
    App.chat.print_message("系統","聊天室已連接")

  $("#message > #submit").click (event) ->
    event.preventDefault()
    input = $(this).parent().find("#input")
    if input.val().length > 0
      App.chat.send_message input.val()
      input.val("")
  
  $("#nickname > #submit").click (event) ->
    event.preventDefault()
    input = $(this).parent().find("#input")
    App.chat.register input.val()
    input.val("")




