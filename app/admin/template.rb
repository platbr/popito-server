ActiveAdmin.register Template do
  decorate_with TemplateDecorator
  duplicatable via: :save
  menu priority: 1

  filter :name_cont, label: 'Name'
  filter :kind, as: :select, collection: Template.kinds

  json_editor

  form do |f|
    f.semantic_errors
    f.inputs do
      input :kind
      input :name
      input :description
      input :build_config, as: :json
    end
    
    f.actions
  end

  index do
    selectable_column
    id_column
    column :kind
    column :name
    column :description
    actions
  end

  permit_params :name, :label, :kind, :description, :token, :build_config
  
end
