ActiveAdmin.register MyMountain do
	index do
		selectable_column
		default_actions
		column :id
		column :mountain
		column :user
		column :type
	end    
end