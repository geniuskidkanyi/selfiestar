class SubscribesController < ApplicationController
  skip_before_action :check_country, only: [:create, :new]
  def new
    @subscribe = Subscribe.new
  end
  def create
    @subscribe = Subscribe.create(subscribe_params)
    ip = GeoIP.new(Rails.root.join("public/GeoIP.dat")).country(request.remote_ip)
    @subscribe.country = ip.country_name

        if @subscribe.save
            redirect_to subscribe_path, notice: 'you have successfully subscribe.'

        else
          render 'new'

        end

  end
private

def subscribe_params
    params.require(:subscribe).permit(:name, :email)
end

end
