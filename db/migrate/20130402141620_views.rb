class Views < ActiveRecord::Migration
  def up
    create_table :view_counts do |t|
    	t.integer			:photo_id
    	t.integer			:user_id
    	t.string			:ip_address
      t.date        :view_date
      t.timestamps
    end
  end
  def down
  	drop_table :view_counts
  end
end
