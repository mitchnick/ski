class AddMountainIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mountain_id, :integer
  end
end
