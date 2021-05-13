# frozen_string_literal: true

class Template < ApplicationRecord
  include ValidateBuildConfig

  enum kind: { generic: 0, rails: 1 }, _prefix: :kind

  has_many :projects
  has_many :file_patches, as: :owner
  has_many :deploying_resources, class_name: 'DeployingResource', as: :owner
  has_many :fragments, class_name: 'FileResource::Fragment', as: :owner
  has_many :project_files, class_name: 'FileResource::ProjectFile', as: :owner
  has_many :building_files, class_name: 'FileResource::BuildingFile', as: :owner
  has_many :dockerfiles, class_name: 'FileResource::Dockerfile', as: :owner
  has_many :deploying_files, class_name: 'FileResource::DeployingFile', as: :owner
end
