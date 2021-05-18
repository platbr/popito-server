# frozen_string_literal: false

module Archiver
  class Build < Archiver::Base
    TARGET_DIR_NAME = '_popito/build'.freeze
    def generate
      self.filename = "building_files_#{@project.label}.tar.gz"
      self.content_type = 'application/tar+gzip'
      self.data = generate_tgz(files: [metadata_file] + files_to_pack + patched_files)
    end

    def metadata_file
      data = Archiver::Metadata::Build.new
      @project.dockerfiles.or(@project.template.dockerfiles).order(:owner_priority).each do |dockerfile|
        data.add_image(context: @context, dockerfile: dockerfile)
      end
      FileResource::File.new(owner: @project.template, path: 'build.yaml', data: data.to_yaml)
    end

    def files_to_pack
      @project.template.dockerfiles + @project.template.building_files + @project.template.project_files +
        @project.dockerfiles + @project.building_files + @project.project_files
    end

    def patched_files
      files = []
      @project.file_patches.or(@project.template.file_patches).order(:owner_priority, :order)
              .group_by(&:path).each do |path, file_patches|
        file_content = included_file_content_by_path(path)
        file_patches.each do |file_patch|
          if file_content.nil?
            next if file_patch.optional

            raise CustomError.new(
              status: 422,
              message: I18n.t('popito.failure.missing_included_file', path: path)
            )
          end
          patcher_class = Object.const_get("Patcher::#{file_patch.kind.camelcase}")
          patcher = patcher_class.new(content: file_content, file_patch: file_patch)
          file_content = patcher.patched_content
        end
        files << FileResource::ProjectFile.new(path: path, data: file_content)
      end
      files
    end

    def generate_tgz(files:)
      gzip = Zlib::GzipWriter.new(StringIO.new)
      tar = Gem::Package::TarWriter.new(gzip)
      docker_ignore_content ||= %(
.dockerignore
#{TARGET_DIR_NAME}/*
)
      files.each do |file|
        if file.instance_of?(FileResource::ProjectFile)
          file_path = file.path
        else
          file_path ||= "#{TARGET_DIR_NAME}/#{file.path}"
          docker_ignore_content << "!#{file_path}\n" if file.instance_of?(FileResource::BuildingFile)
        end
        add_file_to_tar(tar, file_path, file.chmod, file.render(context: @context, enable_comments: true))
      end
      add_file_to_tar(tar, "#{TARGET_DIR_NAME}/.dockerignore", '0640', docker_ignore_content)
      add_file_to_tar(tar, "#{TARGET_DIR_NAME}/build_context.yaml", '0640', @context.to_hash.to_yaml)
      tar.close
      gzip.close.string
    end
  end
end
