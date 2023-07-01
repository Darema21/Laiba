class AddOpenIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :open_id, :string
  end
end
