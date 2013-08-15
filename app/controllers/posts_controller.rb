class PostsController < ApplicationController

  before_filter :enforce_logged_in, :only => [:new, :create]

  def new
    @post = Post.new
    @friend_circles = current_user.friend_circles
    render :new
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    if @post.save
      circles = params[:shares]
      circles.each do |circle|
        next if circle == ""
        PostShare.create!(friend_circle_id: circle, post_id: @post.id)
      end
      redirect_to @post
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    @friend_circles = current_user.friend_circles
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    if @post.save
      circles = params[:shares] #array of friend_circle ids

      #remove unchecked friend_circles
      @post.post_shares.each do |share|
        unless circles.include?(share.friend_circle_id)
          share.delete
          circles.delete(share.friend_circle_id) #optimization
        end
      end

      #add new circles to post
      circles.each do |circle|
        unless @post.friend_circle_ids.include?(circle)
          PostShare.create!(friend_circle_id: circle, post_id: @post.id)
        end
      end
      redirect_to @post
    else
      render :edit
    end
  end

end
