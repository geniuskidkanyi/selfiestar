class RegistrationsController < Devise::RegistrationsController
  before_action :confirm_two_factor_authenticated, except: [:cancel]

  def new
    super
  end

  def create
      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end


  def update
    super
  end

  protected

  def update_resource(resource, params)
   resource.update_without_password(params.except(:current_password))
 end

 def confirm_two_factor_authenticated
  return if is_fully_authenticated?

  flash[:error] = t('devise.errors.messages.user_not_authenticated')
  redirect_to user_two_factor_authentication_url
end
end
