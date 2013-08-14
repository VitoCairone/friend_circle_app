module ApplicationHelper
  def login!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def enforce_logged_in
    redirect_to new_session_url unless logged_in?
  end
end
