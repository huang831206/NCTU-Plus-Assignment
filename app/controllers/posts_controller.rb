class PostsController < ApplicationController

  layout "post_layout"

  def index
    @posts = Post.page(params[:page]).per(5)
  end
  
  def new
    @post = Post.new
  end


  def create
    @post = Post.new(post_params)
    begin
      if @post.save
        flash[:notice] = "成功張貼公告：#{@post.title}"
        ChatChannel.broadcast_system_msg "新公告：#{@post.title}"
        redirect_to posts_path
      else
        raise "DB error"
      end
    rescue
      flash[:notice] = "發生錯誤，無法存進資料庫。是否標題空白或格式錯誤？"
      redirect_to new_post_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    begin
      if @post.update(post_params) 
        flash[:notice] = "成功更新公告：#{@post.title}"
        ChatChannel.broadcast_system_msg "公告更新：#{@post.title}"
        redirect_to posts_path
      else
        raise "DB error"
      end
    rescue
      flash[:notice] = "更新失敗，無法存進資料庫。是否標題空白或格式錯誤？"
      redirect_to edit_post_path @post
    end
  end

  def destroy
    @post = Post.find params[:id]
    if @post.destroy
      flash[:notice] = "已成功移除公告：#{@post.title}"
      ChatChannel.broadcast_system_msg "公告已刪除：#{@post.title}"
    else
      flash[:notice] = "移除公告時發生錯誤：#{@post.title}"
    end
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit :title, :open_time, :close_time
  end
end
