# frozen_string_literal: true

module FileResource
  class BuildingFile < FileResource::Base
    validates :path, presence: true
  end
end
