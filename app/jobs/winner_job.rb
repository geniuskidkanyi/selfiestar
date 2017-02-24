class WinnerJob < ApplicationJob
  queue_as :default

  def perform(create)

    w = Winner.create(
    date: Time.now,
    likes: winner.selfy.likes_count,
    user_id: winner.user.id,
    selfy_id: winner.selfy.id
    )
  end
end
