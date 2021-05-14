# frozen_string_literal: true

module FileResource
  class File < ApplicationRecord
    self.table_name = :file_resources

    include CustomSanitizer
    include HasOwner
    include FileRender

    enum render_engine: { disabled: 0, erb: 1 }, _prefix: :render_engine

    belongs_to :chain_fragment, class_name: 'FileResource::Fragment', optional: true

    validates :data, presence: true
    validates :render_engine, presence: true
    validates_uniqueness_of :path, scope: %i[owner_type owner_id], allow_blank: true
    validates_uniqueness_of :label, scope: %i[owner_type owner_id], allow_blank: true
    validate :check_params

    def check_params
      return if instance_of?(FileResource::DeployingModel)

      errors.add(:required_params, 'can be used only for a FileResource::DeployingModel') unless required_params.empty?
      errors.add(:optional_params, 'can be used only for a FileResource::DeployingModel') unless required_params.empty?
    end
  end
end
