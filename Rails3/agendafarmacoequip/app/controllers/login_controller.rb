class LoginController < ApplicationController
  before_filter :authenticate_usuario!

  def calendario
    redirect_to :controller => 'calendar', :action => 'index'
  end
end
