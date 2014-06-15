class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?


  protect_from_forgery with: :exception

  def events_ad
    Myad.state_machine.events.map &:name
  end

  def states_ad
    Myad.state_machine.states.map &:name
  end

  protected
    def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u| 
    	u.permit(:first_name,
    		      :last_name,
    		      :email,
    		      :password,
    		      :password_confirmation,
    		      :reset_password_token,
    		      :reset_password_sent_at,
    		      :remember_created_at) 
      end
    end

end
