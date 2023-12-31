class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  include PigeonsHelper
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :nickname])
  end
end
