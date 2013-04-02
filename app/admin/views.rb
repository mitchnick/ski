ActiveAdmin.register View do
	index do
		selectable_column
		default_actions
		column :id
		column :ip_address
		column :user
		column :photo
		column :view_date
	end  
end
