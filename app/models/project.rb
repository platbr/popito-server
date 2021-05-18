# frozen_string_literal: true

class Project < ApplicationRecord
  include ValidateBuildConfig
  belongs_to :template
  has_many :environments, dependent: :destroy
  has_many :file_patches, as: :owner, dependent: :destroy
  has_many :deploying_resources, class_name: 'DeployingResource', as: :owner, dependent: :destroy
  has_many :fragments, class_name: 'FileResource::Fragment', as: :owner, dependent: :destroy
  has_many :project_files, class_name: 'FileResource::ProjectFile', as: :owner, dependent: :destroy
  has_many :building_files, class_name: 'FileResource::BuildingFile', as: :owner, dependent: :destroy
  has_many :dockerfiles, class_name: 'FileResource::Dockerfile', as: :owner, dependent: :destroy
  has_many :deploying_files, class_name: 'FileResource::DeployingFile', as: :owner, dependent: :destroy

  validates_uniqueness_of :name
  validates :name, presence: true
  validates :label, presence: true
  validates :token, presence: true

  before_validation :fill_token, if: proc { token.blank? }

  amoeba do
    enable
    prepend name: "Copy of "
    include_association :environments
    include_association :file_patches
    include_association :deploying_resources
    include_association :fragments
    include_association :project_files
    include_association :building_files
    include_association :dockerfiles
    include_association :deploying_files
  end

  accepts_nested_attributes_for :environments, allow_destroy: true

  private

  def fill_token
    self.token = SecureRandom.uuid
  end
end
