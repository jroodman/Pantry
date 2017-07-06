class AddWarningDate < ActiveRecord::Migration[5.1]
  def up
    change_column :items, :expiration_date, :datetime, null: true
    add_column :items, :warning_date, :datetime
  end
  def down
    change_column :items, :expiration_date, :datetime, null: false
    remove_column :items, :warning_date, :datetime
  end
end
