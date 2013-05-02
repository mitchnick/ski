class ChangeTimeTakenWordingOnPhotos < ActiveRecord::Migration
  def change
   	rename_column :photos, :time_taken, :taken_time
  end
end
