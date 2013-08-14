class UsersController < ApplicationController

  before_filter :enforce_logged_in, :only => :feed

  def create
    @user = User.new(params[:user])
    if @user.save
      login!(@user)
      redirect_to feed_url
    else
      render :new
    end
  end

  def feed
    render :feed
  end

  def new
    render :new # not actually required
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

end
