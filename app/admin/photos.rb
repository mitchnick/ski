ActiveAdmin.register Photo do
	index do
		selectable_column
		default_actions
		column :name
	end  
end