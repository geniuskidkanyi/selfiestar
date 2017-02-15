module PagesHelper
  def gravatar_user(user, options = { size: 30 })
      size = options[:size]
      gravatar_url = "http://beta.selfiestar.gm/avatar.jpg"
      avatar_url = user.avatar? ? user.avatar.url : gravatar_url
      image_tag(avatar_url, alt: user.username, class: "card-main-image")
  end
end
