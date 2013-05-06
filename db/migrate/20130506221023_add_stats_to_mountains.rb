class AddStatsToMountains < ActiveRecord::Migration
  def change
  	add_column :mountains, :stats, :text
  end
end
