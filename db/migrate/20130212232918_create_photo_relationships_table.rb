class CreatePhotoRelationshipsTable < ActiveRecord::Migration
  def change
  	create_table :photo_relationships do |t|
  		t.integer :photo_id
  		t.integer :user_id
  		t.integer :role_id

  		t.timestamps
  	end
  add_index :photo_relationships, :photo_id
  add_index :photo_relationships, :user_id
	end
end
