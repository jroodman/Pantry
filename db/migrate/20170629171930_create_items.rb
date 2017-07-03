class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :category_small, null: false
      t.string :category_large, null: false
      t.integer :quantity, null: false, default: 1
      t.datetime :expiration_date, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
