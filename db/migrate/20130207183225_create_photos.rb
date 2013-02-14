class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string 			:name
      t.integer			:creator
      t.integer			:photographer
      t.integer			:rider
      t.integer			:mountain
      t.string			:mountain_fat
      t.string			:camera_type
      t.string			:lens_type
      t.string			:aperture
      t.string			:shutter_speed
      t.string			:focal_length
      t.integer			:views
      t.string			:license_attr
      t.string			:url
      t.string			:current_path
      t.string			:identifier
      t.string			:city
      t.string			:state
      t.string			:zipcode
      t.text			:description


      t.timestamps
    end
    add_index :photos, [:name, :photographer, :mountain]
  end
end