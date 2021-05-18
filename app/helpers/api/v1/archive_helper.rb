# frozen_string_literal: true

module Api
  module V1
    module ArchiveHelper
      include CustomSanitizer
      def render_archiver(archiver:)
        should_be('archiver', archiver, Archiver::Base)
        archiver.generate
        return send_data archiver.data, type: archiver.content_type, filename: archiver.filename if archiver.data

        raise CustomError.new(status: 422, message: I18n.t('popito.failure.empty_archive'))
      end
    end
  end
end
