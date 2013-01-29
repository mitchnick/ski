class AddWheretoskiFieldsToUser < ActiveRecord::Migration
  def change

	    ## Where to ski Fields in User Database 
	    add_column :users, :first_name,		:string 
	    add_column :users, :last_name ,		:string 
	    add_column :users, :bio, 			:text
	    add_column :users, :home_town, 		:string 
	    add_column :users, :home_mountain, 	:string
	    add_column :users, :terms, 			:boolean 
	    add_column :users, :email_opt_in, 	:boolean 
	    add_column :users, :photo, 			:string 	

  end
end
