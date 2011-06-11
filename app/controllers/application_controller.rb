class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate_and_redirect
    session[:redirect_to] = request.path
    authenticate_user!
  end

end
