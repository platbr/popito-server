# frozen_string_literal: true

module FileResource
  class Fragment < FileResource::Base
    include HasEmptyPath
  end
end
