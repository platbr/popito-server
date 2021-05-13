# frozen_string_literal: true

module Archiver
  module Metadata
    class Base
      include CustomSanitizer
      attr_accessor :data

      def initialize
        self.data = {}
      end

      def to_yaml
        data.deep_stringify_keys.to_yaml
      end
    end
  end
end
