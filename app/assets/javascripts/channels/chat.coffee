App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    @print_message("系統","聊天室已連接")

  disconnected: ->
    # Called when the subscription has been terminated by the server
    @print_message("系統","聊天室已中斷連線")

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(data)
  
  send_message: (message) ->
    @perform "send_message", {uuid: 123, message: message}

  print_message: (sender,message) ->
    console.log(sender + ":" + message)
    #$("#messages").append("<p>#{message}</p>")
