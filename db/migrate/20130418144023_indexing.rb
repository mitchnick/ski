class Indexing < ActiveRecord::Migration
  def change
  	add_index :gnars, 			:photo_id
  	add_index :gnars, 			:user_id
  	add_index :photos, 			:views
  	add_index :regions, 		:name
  	add_index	:view_counts, :photo_id
  	add_index :view_counts, :user_id
  end
end
