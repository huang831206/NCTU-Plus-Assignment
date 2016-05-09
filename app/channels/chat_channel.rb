# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    nickname = self.class.find_nickname(uuid)
    if nickname
      self.class.broadcast({action: "message", sender: "系統", message:"'#{nickname}'已離開"})
      self.class.remove_user_by_uuid(uuid)
    end
  end


  # data: uuid, message
  def send_message(data)
    nickname = self.class.find_nickname(data["uuid"])
    if nickname
      self.class.broadcast({
        action: "message", 
        sender: nickname,
        message: data["message"],
      })
    end
    # No message for un-registered uuid
  end

  # data: token, nickname
  def register(data)
    new_uuid = self.uuid
    real_name = self.class.register_username(new_uuid,data["nickname"])
    self.class.broadcast({action: "register", uuid: new_uuid, nickname: real_name, token: data["token"]})
    self.class.broadcast({action: "message", sender: "系統", message:"'#{real_name}'加入聊天室"})
  end

  def self.broadcast(data)
    ActionCable.server.broadcast :chat_channel, data
  end

  def self.broadcast_system_msg(msg)
    broadcast({action: "message", sender: "系統", message: msg})
  end

  def self.reset
    REDIS.del "nctuplus.uuid.nickname"
    REDIS.del "nctuplus.nickname"
    REDIS.del "nctuplus.nickname.guest.count"
  end

  def self.generate_uuid
    SecureRandom.uuid
  end

  def self.find_nickname(uuid)
    REDIS.hget("nctuplus.uuid.nickname",uuid)
  end

  def self.register_username(uuid,nickname)
    nickname.strip!
    if nickname.empty? || nickname =~ /系統/
      # treat as Guest
      REDIS.incr("nctuplus.nickname.guest.count")
      nickname = "Guest_#{REDIS.get('nctuplus.nickname.guest.count')}"
    end
    # check user nickname
    if REDIS.hexists("nctuplus.nickname",nickname)
      REDIS.hincrby("nctuplus.nickname",nickname,1)
      nickname = "#{nickname}_#{REDIS.hget('nctuplus.nickname',nickname)}"
    end
    #  here, nickname must be unique
    REDIS.hset("nctuplus.nickname", nickname, 1)
    # Save in uuid
    REDIS.hset("nctuplus.uuid.nickname", uuid, nickname)
    return nickname
  end


  def self.remove_user_by_uuid(uuid)
    REDIS.hdel("nctuplus.uuid.nickname",uuid)
  end
end
