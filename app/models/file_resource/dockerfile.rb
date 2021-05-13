# frozen_string_literal: true

module FileResource
  class Dockerfile < FileResource::Base
    validates :path, presence: true
    validates :label, presence: true

    private

    def turn_on_comments
      true
    end
  end
end
