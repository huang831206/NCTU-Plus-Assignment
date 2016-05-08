if ENV["HEROKU_REDIS_SILVER_URL"]
  host = URI.parse(ENV["HEROKU_REDIS_SILVER_URL"]).host
  REDIS = Redis.new(:host => host)
else
  REDIS = Redis.current
end

