class PagesController < ApplicationController
  def home
    @selfies = Selfy.all.order(created_at: :desc)
    @week_trendings = trending

  end
  def upload
    @selfie = Selfy.new
  end

  def profile
    @user = current_user
    @selfies = current_user.selfies.all.order(created_at: :desc)
  end

  private

def trending
  date = DateTime.now.utc
  likes = Like.where('created_at >= ? and created_at <= ?', date.beginning_of_week, date.utc.end_of_week).select(:selfy_id)
  top = Selfy.where(id: likes)
  top.order("COALESCE(likes_count, 0) DESC").limit(10)
end



end