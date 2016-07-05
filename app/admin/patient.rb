ActiveAdmin.register Patient do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  form do |f|
    f.inputs "General" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :gender
      f.input :phone
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :phone
    column :email
    column :first_name
    column :last_name
    column :created_at
    actions
  end

end
