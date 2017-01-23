class CreateSelfies < ActiveRecord::Migration[5.0]
  def change
    create_table :selfies do |t|
      t.string :title
      t.string :photo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
