class CreateSubscribes < ActiveRecord::Migration[5.0]
  def change
    create_table :subscribes do |t|
      t.string :name
      t.string :email
      t.string :country

      t.timestamps
    end
  end
end
