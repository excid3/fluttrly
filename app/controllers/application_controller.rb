class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource_or_scope)
    if session[:redirect_to]
      session[:redirect_to]
    else
     super
    end
  end
end
