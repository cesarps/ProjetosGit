class LoginController < ApplicationController

  before_filter :authenticate_usuario!
  before_filter :configure_permitted_parameters, if: :devise_controller?


  def calendario
    redirect_to :controller => 'calendar', :action => 'index'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :ramal
  end


end
