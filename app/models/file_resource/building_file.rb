# frozen_string_literal: true

module FileResource
  class BuildingFile < FileResource::File
    validates :path, presence: true
  end
end
