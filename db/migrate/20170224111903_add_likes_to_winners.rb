class AddLikesToWinners < ActiveRecord::Migration[5.0]
  def change
    add_column :winners, :likes, :string
  end
end
