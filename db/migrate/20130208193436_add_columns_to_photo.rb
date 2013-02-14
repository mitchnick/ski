class AddColumnsToPhoto < ActiveRecord::Migration
  def change
  	add_column :photos, 	:description,		:text
  	add_column :photos, 	:image_thumb, 		:string
  	add_column :photos, 	:image_max_width, 	:string
  	add_column :photos,		:width,				:string
  	add_column :photos, 	:height,			:string
  	add_column :photos, 	:taken_time,		:date
  	add_column :photos, 	:admin_description,	:text
  end
end
