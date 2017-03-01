class AdminController < ApplicationController
    before_action :admin_user
  def dashboard
    @events = Ahoy::Event.all
  end
end
