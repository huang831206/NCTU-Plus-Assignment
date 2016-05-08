App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    window.chat = {}
    if document.readyState is "complete"
      @print_message("系統","聊天室已連接")
      window.show_msg = true

  disconnected: ->
    # Called when the subscription has been terminated by the server
    @print_message("系統","聊天室已中斷連線")
    window.chat = undefined
    $("#nickname").show()
    $("#nickname > input").focus()
    $("#message").hide()

  register: (nickname) ->
    if typeof window.chat is "object"
      window.chat["reg_token"] = Math.random()
      @perform "register", {nickname: nickname, token: window.chat["reg_token"]}
    else
      console.log "Chat room not connected"

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    switch data["action"]
      when "message"
        @print_message(data["sender"],data["message"])
      when "register"
        if data["token"] is window.chat["reg_token"]
          window.chat["uuid"] = data["uuid"]
          window.chat["nickname"] = data["nickname"]
          window.chat["reg_token"] = null # dont register next time
          @print_message("系統","暱稱已設定為" + window.chat["nickname"])
          $("#nickname").hide()
          $("#message").show()
          $("#message > input").focus()
        else
          # Ignore register message

  
  send_message: (message) ->
    if typeof window.chat is "object"
      @perform "send_message", {uuid: window.chat["uuid"], message: message}
    else
      console.log "Chat room not connected"

  print_message: (sender,message) ->
    console.log(sender + ":" + message)
    if document.readyState is "complete"
      html = $("<tr><td>#{sender}</td><td>#{message}</td></tr>")
      if sender is "系統"
        html.addClass("info")
      else if sender is window.chat["nickname"]
        html.addClass("success")
      $("#chat > tbody").append html
      $('html, body').stop()
      $('html, body').animate({
          scrollTop: $("#message > #input").offset().top
      }, 500)
