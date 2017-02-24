class WinnersController < ApplicationController
  before_action :set_winners
  def create

    Winner.create(
    date: Time.now,
    likes: winner.selfy.likes_count,
    user_id: winner.user.id,
    selfy_id: winner.selfy.id
    )
  end
private

def set_winners
  date = DateTime.now.utc
  likes = Like.where('created_at >= ? and created_at <= ?', 2.week.ago.beginning_of_week, 1.week.ago.end_of_week).select(:selfy_id)
  top = Selfy.where(id: likes)
  top.order("COALESCE(likes_count, 0) DESC").limit(1)
end

end
