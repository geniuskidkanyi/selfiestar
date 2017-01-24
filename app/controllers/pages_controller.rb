class PagesController < ApplicationController
  def home
    @selfies = Selfie.all.order(created_at: :desc).reverse
  end
  def upload
    @selfie = Selfie.new
  end
end
