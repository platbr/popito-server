ActiveAdmin.register DeployingResource do
  duplicatable via: :save
  decorate_with DeployingResourceDecorator
  menu priority: 4

  filter :path_cont, label: 'Path'
  filter :deploying_model
  filter :owner_of_Template_type_id_eq, as: :select, collection: Template.select(:id,:name), label: 'Template'
  filter :owner_of_Project_type_id_eq, as: :select, collection: Project.select(:id,:name), label: 'Project'

  json_editor

  form do |f|
    f.semantic_errors
    f.inputs do
      input :owner, collection: AdminOwnerHelper.all_owners
      input :deploying_model
      input :path
      input :chmod
      input :params, as: :json
    end
    
    f.actions
  end

  index do
    selectable_column
    id_column
    column :owner
    column :path
    actions
  end

  permit_params :owner_type, :owner_id, :deploying_model_id, :path, :chmod, :params  
end
