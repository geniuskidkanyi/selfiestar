module ApplicationHelper
  def full_title(page_title = '')
      base_title = "Selfiestar"
      if page_title.empty?
          base_title
      else
          " #{base_title} | #{page_title}"
      end
  end

  def winner
    date = DateTime.now.utc
    likes = Like.where('created_at >= ? and created_at <= ?', 2.week.ago.beginning_of_week, 1.week.ago.end_of_week).select(:selfy_id)
    top = Selfy.where(id: likes)
    top.order("COALESCE(likes_count, 0) DESC").limit(1)
  end
  def gravatar_for(user, options = { size: 30 })
      size = options[:size]
      gravatar_url = "http://beta.selfiestar.gm/avatar.jpg"
      avatar_url = user.avatar? ? user.avatar.url : gravatar_url
      image_tag(avatar_url, alt: user.username, class: "card-footer-avater-image")
  end
  def flash_messages(options = {})
      flash_messages = []
      flash.each do |type, message|
        type = type.to_sym
        type = :success if type == :notice
        type = :error   if type == :alert
        type = :error   if type == :danger
        text = "<script>toastr.#{type}('#{message}');</script>"
        flash_messages << text.html_safe if message
      end
      flash_messages.join("n").html_safe
  end
end
