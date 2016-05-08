if ENV["HEROKU_REDIS_SILVER_URL"]
  REDIS = Redis.new(:host => ENV["HEROKU_REDIS_SILVER_URL"])
else
  REDIS = Redis.current
end

