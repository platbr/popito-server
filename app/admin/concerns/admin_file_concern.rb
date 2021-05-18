# frozen_string_literal: true

module AdminFileConcern
  def self.included(dsl)
    dsl.instance_eval do
      duplicatable via: :save
      decorate_with FileResource::FileDecorator
      menu parent: "Files"

      filter :label_or_path_cont, label: 'Label/Path'
      filter :data_cont, label: 'Content'
      filter :render_engine, as: :select, collection: FileResource::File.render_engines
      filter :owner_of_Template_type_id_eq, as: :select, collection: Template.select(:id,:name), label: 'Template'
      filter :owner_of_Project_type_id_eq, as: :select, collection: Project.select(:id,:name), label: 'Project'

      json_editor

      form do |f|
        resource_object = resource_class.new
        f.semantic_errors
        f.inputs do
          input :owner, collection: AdminOwnerHelper.all_owners if resource_object.needs_owner?
          input :label if resource_object.needs_label?
          input :render_engine
          input :path if resource_object.needs_path?
          input :chmod
          input :comments_prefix
          input :newline
          input :data
        end
        f.actions
      end

      index do
        resource_object = resource_class.new
        selectable_column
        id_column
        column :owner if resource_object.needs_owner?
        column :label if resource_object.needs_label?
        column :path if resource_object.needs_path?
        actions
      end
    
      permit_params :owner_type, :owner_id, :label, :render_engine, :path, :chmod, :comments_prefix, :newline, :data

    end
  end
end
