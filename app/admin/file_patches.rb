ActiveAdmin.register FilePatch do
  duplicatable via: :save
  decorate_with FilePatchDecorator
  menu priority: 5

  filter :name_cont, label: 'Name'
  filter :path_cont, label: 'Path'
  filter :kind, as: :select, collection: FilePatch.kinds
  filter :owner_of_Template_type_id_eq, as: :select, collection: Template.select(:id, :name), label: 'Template'
  filter :owner_of_Project_type_id_eq, as: :select, collection: Project.select(:id, :name), label: 'Project'

  form do |f|
    f.semantic_errors
    f.inputs do
      input :owner, collection: AdminOwnerHelper.all_owners
      input :name
      input :kind
      input :optional
      input :newline_on_append
      input :newline
      input :order
      input :path
      input :search_regex
      input :replace
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :owner
    column :name
    column :order
    column :kind
    column :path
    actions
  end

  permit_params :owner_type, :owner_id, :name, :owner_priority, :order, :path, :kind, :optional, :newline_on_append, :newline,
                :search_regex, :replace
end
