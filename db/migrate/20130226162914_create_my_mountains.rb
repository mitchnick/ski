class CreateMyMountains < ActiveRecord::Migration
  def change
    create_table :my_mountains do |t|
    	t.integer			:user_id
    	t.integer			:mountain_id
    	t.integer			:type
      t.timestamps
    end
  end
end
