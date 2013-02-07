ActiveAdmin.register Mountain do

	action_item :only => :index do
		link_to 'Upload CSV', :action => 'upload_csv'
	end

	collection_action :upload_csv do
		render "admin/csv/upload_csv"
	end

	collection_action :import_csv, :method => :post do
		CsvDb.convert_save("Mountain", params[:dump][:file])
      	flash[:notice] = "CSV imported successfully!"
      	redirect_to :action => :index
	end

	index do
		default_actions
		column :id
		column :name
		column :description 
		column :region
		column :state
		column :updated_at
		column :created_at
	end
end
