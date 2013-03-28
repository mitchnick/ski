class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
    	t.string 	:name
      t.timestamps
    end
    add_column :mountains, :region_id, :integer
    remove_column :mountains, :region
    add_index :mountains, :region_id
  end
end
