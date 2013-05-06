ActiveAdmin.register Mountain do

	controller do
    defaults :finder => :find_by_slug
  end

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
		selectable_column
		default_actions
		column :id
		column :name
		column :description 
		column :region
		column :state
		column :updated_at
		column :created_at
	end

	form do |f|
    f.inputs do
      f.input :name
      f.input :slug 
      f.input :region
      f.input :description, :input_html => {:class => "ckeditor"}
      f.input :stats, :input_html => {:class => "ckeditor"}
      f.input :phone
      f.input :web_link
      f.input :tickets_link
      f.input :trail_map
      f.input :state
      f.input :gps_lat
      f.input :gps_lon
    end

    f.buttons
  end
end
