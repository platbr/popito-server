# frozen_string_literal: true

module FileResource
  class BuildingFile < FileResource::File
    def needs_label?
      false
    end

    def needs_path?
      true
    end

    def needs_owner?
      true
    end
  end
end
