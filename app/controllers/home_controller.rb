class HomeController < ApplicationController
  def index
    time = Time.current
    @posts = Post.where(["(open_time is null OR open_time <= ?) AND (close_time is null OR close_time >= ?)", time, time])
  end
end
