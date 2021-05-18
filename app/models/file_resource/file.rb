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

    validate :validate_some_attributes
    validates :data, presence: true
    validates :chmod, presence: true
    validates :comments_prefix, presence: true
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

    def needs_label?
      raise NotImplementedError
    end

    def needs_path?
      raise NotImplementedError
    end

    def needs_owner?
      raise NotImplementedError
    end

    def validate_some_attributes
      errors.add(:path, I18n.t('errors.messages.blank')) if path.blank? && needs_path?
      errors.add(:label, I18n.t('errors.messages.blank')) if label.blank? && needs_label?
      errors.add(:owner, I18n.t('errors.messages.blank')) if owner.blank? && needs_owner?

      errors.add(:path, I18n.t('errors.messages.present')) if path.present? && !needs_path?
      errors.add(:label, I18n.t('errors.messages.present')) if label.present? && !needs_label?
      errors.add(:owner, I18n.t('errors.messages.present')) if owner.present? && !needs_owner?
    end
  end
end
