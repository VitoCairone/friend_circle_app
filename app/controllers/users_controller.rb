require 'debugger'

class UsersController < ApplicationController

  before_filter :enforce_logged_in, :only => :feed

  def create
    #debugger
    @user = User.new(params[:user])
    if @user.save
      login!(@user)

      circles = params[:shares]
      circles.each do |circle|
        next if circle == ""
        share = PostShare.create!(friend_circle_id: circle, post_id: Post.last.id)
      end

      redirect_to feed_url
    else
      render :new
    end
  end

  def feed
    render :feed
  end

  def new
    @incepted = true
    @post = Post.new
    @friend_circles = FriendCircle.all
    render :new # not actually required
  end

end
