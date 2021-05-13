# frozen_string_literal: true

module Archiver
  class Deploy < Archiver::Base
    TARGET_DIR_NAME = '_popito/deploy'
    def generate
      self.filename = "deploying_files_#{@project.label}.tar.gz"
      self.content_type = 'application/tar+gzip'
      self.data = generate_tgz(files: files_to_pack + resources_to_pack)
    end

    def generate_tgz(files:)
      gzip = Zlib::GzipWriter.new(StringIO.new)
      tar = Gem::Package::TarWriter.new(gzip)
      files.each do |file|
        add_file_to_tar(tar, "#{TARGET_DIR_NAME}/deploy/#{file.path}", file.chmod,
                        file.render(context: @context, enable_comments: true))
      end
      add_file_to_tar(tar, "#{TARGET_DIR_NAME}/deploy_context.yaml", '0640', @context.to_hash.to_yaml)
      tar.close
      gzip.close.string
    end

    def files_to_pack
      @project.template.deploying_files.or(@project.deploying_files).order(:owner_priority)
    end

    def resources_to_pack
      @project.template.deploying_resources.or(@project.deploying_resources).order(:owner_priority)
    end
  end
end
