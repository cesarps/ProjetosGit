class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  include WelcomeHelper
  include LogsHelper


  def autenticado?
    if session[:login].blank? or session[:login].nil?
      redirect_to welcome_login_path
      return false
    end
  end




end


