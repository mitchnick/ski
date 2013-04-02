class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string 			:name
      t.string      :image
      t.integer     :mountain_id
      t.string			:camera_type
      t.string			:lens_type
      t.string			:aperture
      t.string			:shutter_speed
      t.string			:focal_length
      t.integer			:views
      t.string			:license_attr
      t.string			:city
      t.string			:state
      t.string			:zipcode
      t.text			  :description
      t.string      :width
      t.string      :length
      t.date        :time_taken
      t.string      :image_url
      t.string      :remote_image_url
      t.timestamps
    end
    add_index :photos, [:name, :mountain_id, :views]
  end
end