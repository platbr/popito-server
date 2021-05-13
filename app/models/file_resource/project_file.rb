# frozen_string_literal: true

module FileResource
  class ProjectFile < FileResource::Base
    validates :path, presence: true
  end
end
