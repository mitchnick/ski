ActiveAdmin.register Region do
	index do
		selectable_column
		default_actions
		column :id
		column :name
	end  
end
