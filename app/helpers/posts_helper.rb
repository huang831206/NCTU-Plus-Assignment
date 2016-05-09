module PostsHelper
  def fmt_time(time)
    time.in_time_zone("Taipei").strftime("%Y-%m-%d %H:%M %Z")
  end

  def open_time_fmt(time)
    if time
      fmt_time time
    else
      "立即"
    end
  end
  
  def close_time_fmt(time)
    if time
      fmt_time time
    else
      "永不"
    end
  end
end
