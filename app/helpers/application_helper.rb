module ApplicationHelper

  def winner
  # pry.binding
    date = DateTime.now.utc
    likes = Like.where('created_at >= ? and created_at <= ?', 2.week.ago.beginning_of_week, 1.week.ago.end_of_week).select(:selfy_id)
    top = Selfy.where(id: likes)
    top.order("COALESCE(likes_count, 0) DESC").limit(1)
  end
  def gravatar_for(user, options = { size: 30 })
      size = options[:size]
      gravatar_url = "http://localhost:3000/avatar.jpg"
      avatar_url = user.avatar? ? user.avatar.url : gravatar_url
      image_tag(avatar_url, alt: user.username, class: "card-footer-avater-image")
  end

end
