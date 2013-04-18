class AddRiderToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :rider_id, :integer
  	add_index :photos, :rider_id
  end
end
