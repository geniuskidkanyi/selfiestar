class CreateWinners < ActiveRecord::Migration[5.0]
  def change
    create_table :winners do |t|
      t.references :user, foreign_key: true
      t.references :selfy, foreign_key: true
      t.datetime :date

      t.timestamps
    end
  end
end
