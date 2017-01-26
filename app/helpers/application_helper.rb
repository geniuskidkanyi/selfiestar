module ApplicationHelper

  def winner
  # pry.binding
    date = DateTime.now.utc
    likes = Like.where('created_at >= ? and created_at <= ?', 2.week.ago.beginning_of_week, 1.week.ago.end_of_week).select(:selfy_id)
    top = Selfy.where(id: likes)
    top.order("COALESCE(likes_count, 0) DESC").limit(1)
  end

end
