ActiveAdmin.register Project do
  decorate_with ProjectDecorator
  duplicatable via: :save
  exportable includes: [:template, :environments, :file_patches, :fragments, :project_files, :building_files, :dockerfiles, :deploying_files, {deploying_resources: :deploying_model}], format: :json
  menu priority: 2

  filter :name_cont, label: 'Name'
  filter :label_cont, label: 'Label'
  filter :token_cont, label: 'Token'
  filter :template, as: :select

  # TODO: fix json_editor gem to work with nested
  json_editor

  form do |f|
    f.semantic_errors
    f.inputs do
      input :template
      input :name
      input :label
      input :token
      input :description
      input :build_config, as: :json
    end
    f.inputs do
      f.has_many :environments, heading: 'Environments', allow_destroy: true, new_record: true do |env|
        env.input :label
        env.input :build_config, as: :json
      end
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :template
    column :name
    column :label
    column :description
    column :environments
    actions
  end

  permit_params :name, :label, :description, :token, :build_config, :template_id,
                environments_attributes: %i[id label build_config _destroy]
end
