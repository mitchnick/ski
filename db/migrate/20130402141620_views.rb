class Views < ActiveRecord::Migration
  def up
    create_table :views do |t|
    	t.integer			:photo_id
    	t.integer			:user_id
    	t.string			:ip_address
      t.date        :view_date
      t.timestamps
    end
  end
  def down
  	drop_table :views
  end
end
