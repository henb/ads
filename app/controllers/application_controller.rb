class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  # Catch all CanCan errors and alert the user of the exception
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_path
    flash[:info] = exception.message
  end

  def events_ad
    Myad.state_machine.events.map &:name
  end

  def states_ad
    Myad.state_machine.states.map &:name
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def admin?
    current_user && current_user.admin?
  end

  def events_valid?(event)
    [event] & (admin? ? Myad.admin_events : Myad.user_events)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name,
               :last_name,
               :email,
               :password,
               :password_confirmation)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name,
               :last_name,
               :email,
               :password,
               :password_confirmation,
               :current_password)
    end
  end
end
