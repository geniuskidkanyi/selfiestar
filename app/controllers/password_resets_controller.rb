class PasswordResetsController < ApplicationController
    before_action :get_user, only: [:edit, :update]
    before_action :check_expiration, only: [:edit, :update]
    def new
    end

    def edit

    end

    def update
        if password_blank?
            flash.now[:danger] = "Password can't be blank"
            render 'edit'
        elsif @user.update_attributes(user_params)
            sign_in @user
            flash[:success] = 'Password has been reset.'
            redirect_to root_url
        else
            render 'edit'
        end
    end

    def token
    end

    def find_token
        # binding.pry
        @user = User.find_by(reset_password_token: params[:password_reset][:reset_password_token])
        if @user

            redirect_to edit_password_reset_url(@user.reset_password_token, username: @user.username)
        else
            flash.now[:danger] = 'token not valib'
            redirect_to root_url
        end
    end

    def create
        @user = User.find_by(username: params[:password_reset][:username].downcase)
        if @user
            @user.create_reset_digest
            @user.send_password_reset_sms
            flash[:info] = 'Sms sent with password reset instructions'
            redirect_to token_url
        else
            flash[:danger] = 'Username not found'
            render 'new'
        end
    end

    private

    # before filters
    def get_user
        @user = User.find_by(username: params[:username])
        if @user.nil?
          flash[:danger] = 'User not found'
          redirect_to root_url

        end
    end

    def user_params
        params.require(:user).permit(:password, :password_confirmation)
    end

    # Returns true if password is blank.
    def password_blank?
        params[:user][:password].blank?
    end
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end

end
