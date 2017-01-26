class PagesController < ApplicationController
  def home
    @selfies = Selfie.all.order(created_at: :desc).reverse
    @week_trendings = trending
    @winner = winner
  end
  def upload
    @selfie = Selfie.new
  end

  private

def trending
  date = DateTime.now.utc
  likes = Like.where('created_at >= ? and created_at <= ?', date.beginning_of_week, date.utc.end_of_week).select(:selfie_id)
  top = Selfie.where(id: likes)
  top.order("COALESCE(likes_count, 0) DESC").limit(10)
end

def winner

  date = DateTime.now.utc
  likes = Like.where('created_at >= ? and created_at <= ?', 2.week.ago.beginning_of_week, 1.week.ago.end_of_week).select(:selfie_id)
  top = Selfie.where(id: likes)
  top.order("COALESCE(likes_count, 0) DESC").limit(1)
end

end
