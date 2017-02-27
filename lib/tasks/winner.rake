namespace :winner do
  desc "Generate winner"
  task :create_winner => :environment do
# binding.pry
      date = DateTime.now.utc
      likes = Like.where('created_at >= ? and created_at <= ?', 2.week.ago.beginning_of_week, 1.week.ago.end_of_week).select(:selfy_id)
      top = Selfy.where(id: likes)
      @selfy = top.order("COALESCE(likes_count, 0) DESC").first
    @winner = Winner.create(
    date: Time.now,
    user_id: @selfy.user_id,
    selfy_id: @selfy.id,
    likes: @selfy.likes_count,
    views: @selfy.impressionist_count
    )
  end

end
