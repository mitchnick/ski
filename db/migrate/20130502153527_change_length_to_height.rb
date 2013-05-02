class ChangeLengthToHeight < ActiveRecord::Migration
  def change
  	rename_column :photos, :length, :height
  end
end
