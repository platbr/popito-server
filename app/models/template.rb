# frozen_string_literal: true

class Template < ApplicationRecord
  include ValidateBuildConfig

  enum kind: { generic: 0, rails: 1 }, _prefix: :kind

  has_many :projects, dependent: :restrict_with_error
  has_many :file_patches, as: :owner, dependent: :destroy
  has_many :deploying_resources, class_name: 'DeployingResource', as: :owner, dependent: :destroy
  has_many :fragments, class_name: 'FileResource::Fragment', as: :owner, dependent: :destroy
  has_many :project_files, class_name: 'FileResource::ProjectFile', as: :owner, dependent: :destroy
  has_many :building_files, class_name: 'FileResource::BuildingFile', as: :owner, dependent: :destroy
  has_many :dockerfiles, class_name: 'FileResource::Dockerfile', as: :owner, dependent: :destroy
  has_many :deploying_files, class_name: 'FileResource::DeployingFile', as: :owner, dependent: :destroy

  validates_uniqueness_of :name
  validates :name, presence: true

  amoeba do
    enable
    prepend :name => "Copy of "
    include_association :file_patches
    include_association :deploying_resources
    include_association :fragments
    include_association :project_files
    include_association :building_files
    include_association :dockerfiles
    include_association :deploying_files
  end

end
