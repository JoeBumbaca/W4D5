class ApplicationController < ActionController::Base

  def login!(user)
    # generate new session token and assign it to the cookie!
    session[:session_token] = user.reset_session_token!
  end

  def logged_in?
    !!current_user
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logout!
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
    @current_user = nil
  end

end
