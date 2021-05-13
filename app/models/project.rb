# frozen_string_literal: true

class Project < ApplicationRecord
  include ValidateBuildConfig

  belongs_to :template
  has_many :environments
  has_many :file_patches, as: :owner
  has_many :deploying_resources, class_name: 'DeployingResource', as: :owner
  has_many :fragments, class_name: 'FileResource::Fragment', as: :owner
  has_many :project_files, class_name: 'FileResource::ProjectFile', as: :owner
  has_many :building_files, class_name: 'FileResource::BuildingFile', as: :owner
  has_many :dockerfiles, class_name: 'FileResource::Dockerfile', as: :owner
  has_many :deploying_files, class_name: 'FileResource::DeployingFile', as: :owner
end
