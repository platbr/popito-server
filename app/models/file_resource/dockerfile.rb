# frozen_string_literal: true

module FileResource
  class Dockerfile < FileResource::File
    def needs_label?
      true
    end

    def needs_path?
      true
    end

    def needs_owner?
      true
    end

    private

    def turn_on_comments
      true
    end
  end
end
