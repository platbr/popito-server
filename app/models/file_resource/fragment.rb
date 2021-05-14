# frozen_string_literal: true

module FileResource
  class Fragment < FileResource::File
    include HasEmptyPath
  end
end
