class AddForHireToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :for_hire, :boolean, default: false, null: false
  end
end
