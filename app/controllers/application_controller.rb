require 'ipaddr'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_country, :except => [:subscribe]

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
  request_ip = IPAddr.new request.remote_ip # => Parse from text to IP Address
  unless gambian_blocks.any? { |block| block.include?(request_ip) }
    redirect_to subscribe_path
  end
end

def gambian_blocks
    %w{
      197.242.143.0/24
      197.255.207.0/24
      212.60.95.0/24
    }.map { |subnet| IPAddr.new subnet }
  end
end
