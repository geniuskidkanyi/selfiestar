class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
def configure_permitted_parameters
devise_parameter_sanitizer.permit(:sign_up, keys: [:country_code, :phone_number, :username])
devise_parameter_sanitizer.permit(:account_update, keys: [:country_code, :phone_number, :username])
end
end
