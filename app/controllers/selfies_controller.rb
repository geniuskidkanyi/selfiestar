class SelfiesController < ApplicationController
    def create
        @selfie = Selfie.create(selfie_params)
        @selfie.user_id = current_user.id
        respond_to do |format|
            if @selfie.save
                format.html { redirect_to root_path, notice: 'selfie was successfully created.' }

            else
                format.html { render :new }

            end
        end
    end

    def update
        @selfie = Selfie.find_by(params[i: id])
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
      params.require(:selfie).permit(:title, :photo)
    end
end
