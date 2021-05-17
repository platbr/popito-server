# frozen_string_literal: true

module FileResource
  class File < ApplicationRecord
    self.table_name = :file_resources

    include CustomSanitizer
    include HasOwner
    include FileRender
    include HasNewLine
    include FixOwnerOnDuplicate

    enum render_engine: { disabled: 0, erb: 1 }, _prefix: :render_engine

    validates :data, presence: true
    validates :render_engine, presence: true
    validates_uniqueness_of :path, scope: %i[owner_type owner_id], allow_blank: true
    validates_uniqueness_of :label, scope: %i[owner_type owner_id], allow_blank: true

    def name
      return path if path.present?

      label
    end
    
    amoeba do
      enable
    end
  end
end
