# frozen_string_literal: true

require 'rubygems/package'
module Archiver
  class Base
    include CustomSanitizer
    attr_accessor :data, :content_type, :filename

    def initialize(project:, client_build_config:, included_files: [])
      should_be('project', project, Project)
      should_be('client_build_config', client_build_config, Hash)
      @included_files = included_files || []
      @project = project
      @context = RenderContext.new(project: project, client_build_config: client_build_config)
    end

    def generate
      raise NotImplementedError, 'The archiver must implement generate method.'
    end

    private

    def included_file_content_by_path(path)
      @included_files.each do |include_file|
        next if include_file['encoding'] != 'base64'
        return Base64.decode64 include_file['content'] if include_file['path'] == path
      end
      nil
    end

    def add_file_to_tar(tar, path, permission, data)
      tar.add_file_simple(path, permission, data.bytesize) do |io|
        io.write(data)
      end
    end
  end
end
