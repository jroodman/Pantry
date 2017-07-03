class AddIndices < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :amazon_user_id, :string
    add_index :users, :amazon_user_id, unique: true
    add_foreign_key :items, :users
    add_index :items, :category_small
    add_index :items, :category_large
    add_index :items, :expiration_date
    add_index :items, :name
    add_index :items, :user_id
  end
end
