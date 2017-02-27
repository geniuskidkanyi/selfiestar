class AddViewsToWinners < ActiveRecord::Migration[5.0]
  def change
    add_column :winners, :views, :string
  end
end
