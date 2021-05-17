# frozen_string_literal: true

module FileResource
  class BuildingFile < FileResource::File
    validates :path, presence: true
    validates :owner_id, presence: true
  end
end
