class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def admin_user
    redirect_to(root_url) unless current_user.admin?
end
def configure_permitted_parameters
devise_parameter_sanitizer.permit(:sign_up, keys: [:country_code, :phone_number, :username, :avatar])
devise_parameter_sanitizer.permit(:account_update, keys: [:country_code, :phone_number, :username, :avatar, :current_password])
devise_parameter_sanitizer.permit(:account_reset, keys: [:country_code, :phone_number, :username, :avatar])
end
# def authenticate_user!
#     if user_signed_in?
#       super
#     else
#       redirect_to new_user_session_path
#       ## if you want render 404 page
#       ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
#     end
#   end

end
