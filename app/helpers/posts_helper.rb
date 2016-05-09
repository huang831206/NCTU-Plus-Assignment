module PostsHelper
  def fmt_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end

  def open_time_fmt(time)
    if time
      fmt_time time.in_time_zone("Taipei")
    else
      "立即"
    end
  end
  
  def close_time_fmt(time)
    if time
      fmt_time time.in_time_zone("Taipei")
    else
      "永不"
    end
  end
end
