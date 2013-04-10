class AddSlugToMountains < ActiveRecord::Migration
  def change
  	add_column :mountains, :slug, :string
  	add_column :regions, :slug, :string
  	add_index :mountains, :slug
  	add_index :regions, :slug
  end
end
