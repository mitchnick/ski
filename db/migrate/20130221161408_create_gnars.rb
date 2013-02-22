class CreateGnars < ActiveRecord::Migration
  def change
    create_table :gnars do |t|
    	t.integer     :photo_id
    	t.integer			:user_id
      t.timestamps
    end
  end
end