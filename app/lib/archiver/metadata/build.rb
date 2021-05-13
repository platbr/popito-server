# frozen_string_literal: true

module Archiver
  module Metadata
    class Build < Archiver::Metadata::Base
      def add_image(context:, dockerfile:)
        should_be('context', context, RenderContext)
        should_be('dockerfile', dockerfile, FileResource::Dockerfile)
        data['build'] ||= []
        tags = []
        tags << context.get_value('IMAGE_TAG').to_s
        tags << context.get_value('IMAGE_TAG_ALT').to_s if context.get_value('IMAGE_TAG_ALT', allow_null: true).present?
        image = { dockerfile: dockerfile.path,
                  image: "#{context.get_value('REGISTRY_BASE_URL')}/#{dockerfile.label}",
                  tags: tags.uniq }
        data['build'] << image
        image
      end
    end
  end
end
