class AddWebLinkToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :web_link, :string
  end
end
