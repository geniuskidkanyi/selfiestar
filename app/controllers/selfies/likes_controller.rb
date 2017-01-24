class Selfies::LikesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_selfie
    def create
        @selfie.likes.where(user_id: current_user).first_or_create
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end
    end
def destroy
  @selfie.likes.where(user_id: current_user).destroy_all
  respond_to do |format|
      format.html { redirect_to root_path }
      format.js
  end
end

    private

    def set_selfie
      # pry.binding

        @selfie = Selfie.find(params[:selfy_id])
    end
end
