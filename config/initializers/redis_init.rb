if ENV["HEROKU_REDIS_SILVER_URL"]
  REDIS = Redis.new(:url => ENV["HEROKU_REDIS_SILVER_URL"])
else
  REDIS = Redis.current
end

