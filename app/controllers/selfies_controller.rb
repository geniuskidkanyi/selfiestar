class SelfiesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :show]
    impressionist actions: [:show], unique: [:session_hash]
    impressionist unique: [:session_hash]

    def show
        @selfie = Selfy.find(params[:id])
        
         impressionist(@selfie)
        respond_to do |format|
            format.html
            format.js
        end
    end

    def create
        @selfie = Selfy.create(selfie_params)
        @selfie.user_id = current_user.id
        respond_to do |format|
            if @selfie.save
                format.html { redirect_to root_path, notice: 'selfie was successfully created.' }

            else
                format.html { redirect_to upload_path }

            end
        end
    end

    def update
        @selfie = Selfy.find_by(params[:id])
        respond_to do |format|
            if @selfie.save
                format.html { redirect_to root_path, notice: 'selfie was successfully created.' }

            else
                format.html { render :new }

            end
        end
  end

    protected

    def selfie_params
        params.require(:selfy).permit(:title, :photo)
    end
end
