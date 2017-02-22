class PagesController < ApplicationController
  before_action :authenticate_user!, :only => [:upload, :profile]
  def index
    @selfies = Selfy.all.order(created_at: :desc)

  end
  def home
    @selfies = Selfy.all.order(created_at: :desc)
    # binding.pry
    @week_trendings = trending_wide

    @width = "home"

  end
  def upload
    @selfie = Selfy.new
  end
  def about
    #code
  end
  def profile
    @user = User.find_by_username(params[:username])
    @width = "profile"
    @week_trendings = trending

    @selfies = @user.selfies.all.order(created_at: :desc)
  end

  private
  def trending
    date = DateTime.now.utc
    likes = Like.where('created_at >= ? and created_at <= ?', date.beginning_of_week, date.utc.end_of_week).select(:selfy_id)
    top = current_user.selfies.where(id: likes)
    top.order("COALESCE(likes_count, 0) DESC").limit(6)
  end
def trending_wide
  date = DateTime.now.utc
  likes = Like.where('created_at >= ? and created_at <= ?', date.beginning_of_week, date.utc.end_of_week).select(:selfy_id)
  top = Selfy.where(id: likes)
  top.order("COALESCE(likes_count, 0) DESC").limit(6)
end



end
