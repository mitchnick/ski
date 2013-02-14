class ChangeMountainIdColumn < ActiveRecord::Migration
  def change
  	rename_column :photos, :mountain, :mountain_id
  end
end
