ActiveAdmin.register Region do
	controller do
    defaults :finder => :find_by_slug
  end

	index do
		selectable_column
		default_actions
		column :id
		column :name
	end  
end
