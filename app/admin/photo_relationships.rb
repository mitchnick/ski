ActiveAdmin.register PhotoRelationship do
	index do
		selectable_column
		default_actions
		column :id
		column :role_id
		column :user
		column :photo
	end  
end