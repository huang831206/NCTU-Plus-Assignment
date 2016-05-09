class HomeController < ApplicationController
  def index
    @posts = Post.where(["(open_time is null OR open_time <= ?) AND (close_time is null OR close_time >= ?)", Time.now, Time.now])
  end
end
