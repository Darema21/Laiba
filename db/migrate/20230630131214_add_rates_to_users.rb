class AddRatesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :rates, :json, default: {}
  end
end
