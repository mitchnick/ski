ActiveAdmin.register User do
  
  index do                            
    column :email                     
    column :first_name
    column :last_name
    column :current_sign_in_at
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       
  filter :first_name
  filter :last_name

  form do |f|                         
    f.inputs "User Details" do       
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :bio
      f.input :home_mountain
      f.input :home_town
    end                               
    f.actions                         
  end                                 

end