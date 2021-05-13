# frozen_string_literal: true

module Api
  module V1
    class ArchiveController < ApiController
      include Api::V1::ArchiveHelper

      def create
        case params[:stage]
        when 'build', 'release'
          render_archiver(archiver: Archiver::Build.new(project: current_project,
                                                        client_build_config: build_config_from_params,
                                                        included_files: included_files_from_params))
        when 'predeploy', 'deploy'
          render_archiver(archiver: Archiver::Deploy.new(project: current_project,
                                                         client_build_config: build_config_from_params))
        else
          raise CustomError.new(status: 422, message: 'This stage param is not valid.')
        end
      end

      def included_files_list
        render json: current_project.template.file_patches.or(current_project.file_patches).distinct.pluck(:path)
      end

      private

      def build_config_from_params
        params[:build_config].permit!.to_h
      end

      def included_files_from_params
        params.permit(included_files: %i[encoding path content]).to_h['included_files']
      end
    end
  end
end
