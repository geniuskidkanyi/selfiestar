class AddCounterCacheToSelfies < ActiveRecord::Migration[5.0]
  def change
    add_column :selfies, :likes_count, :integer, default: 0
  end
end
