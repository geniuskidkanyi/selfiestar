require 'ipaddr'
require 'geoip'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_country

  private
  def admin_user
    redirect_to(root_url) unless current_user.admin?
end
def configure_permitted_parameters
devise_parameter_sanitizer.permit(:sign_up, keys: [:country_code, :phone_number, :username, :avatar])
devise_parameter_sanitizer.permit(:account_update, keys: [:country_code, :phone_number, :username, :avatar, :current_password])
devise_parameter_sanitizer.permit(:account_reset, keys: [:country_code, :phone_number, :username, :avatar])
end
def check_country
  # pry.binding
  ip = GeoIP.new(Rails.root.join("public/GeoIP.dat")).country(request.remote_ip)
  unless ip.country_name == "Gambia"
    redirect_to new_subscribe_path
  end
end

end
