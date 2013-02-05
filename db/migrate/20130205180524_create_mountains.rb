class CreateMountains < ActiveRecord::Migration
  def change
    create_table :mountains do |t|
      t.string 	:name
      t.string 	:gps_lat
      t.string 	:gps_lon
      t.text 	  :description
      t.string	:phone
      t.string	:web_link
      t.string	:tickets_link
      t.string	:trail_map
      t.string	:region
      t.string 	:state
      
      t.timestamps
    end
  end
end