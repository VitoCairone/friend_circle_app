class SessionsController < ApplicationController
  include SessionsHelper

  def create
    login
  end

  def new
    render :new
  end

  def destroy
    logout
  end

  def login
    @user = User.authenticate(params[:user])
    if @user
      login!(@user)
      redirect_to feed_url
    else
      render :new
    end
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = SecureRandom.urlsafe_base64(16)
    redirect_to new_session_url
  end
end
