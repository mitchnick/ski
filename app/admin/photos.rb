ActiveAdmin.register Photo do

	index do
		selectable_column
		default_actions
		column :id
		column :name
		column :creator     	
		column :photographer
		column :rider
		column :mountain
	end  
end
