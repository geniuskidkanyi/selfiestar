class PagesController < ApplicationController
  before_action :authenticate_user!, :only => [:upload, :profile]
   after_action :track_action
  def index
    @selfies = Selfy.paginate(:page => params[:page], :per_page => 20).order(created_at: :desc)

  end
  def home
    @selfies = Selfy.paginate(:page => params[:page], :per_page => 20).order(created_at: :desc)
    # binding.pry
    @week_trendings = trending_wide

    @width = "home"

  end
  def browser
    render :layout => false
  end
  def upload
    @selfie = Selfy.new
  end
  def winner
    @winners = Winner.paginate(:page => params[:page], :per_page => 20).order(created_at: :desc)
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
  # binding.pry
  date = DateTime.now.utc
  likes = Like.where('created_at >= ? and created_at <= ?', date.beginning_of_week, date.utc.end_of_week).select(:selfy_id)
  top = Selfy.where(id: likes, created_at: Time.current.all_week)
  top.order("COALESCE(likes_count, 0) DESC").limit(6)
end
  def track_action
    ahoy.track "Viewed #{controller_name}##{action_name}"
  end


end
