# frozen_string_literal: true

class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_client_version
  before_action :check_project

  def check_project
    raise CustomError.new(status: 403, message: I18n.t('popito.failure.invalid_token')) if current_project.nil?
  end

  def current_project
    return nil if request.headers['X-Project-Token'].nil?

    @current_project ||= Project.where(token: request.headers['X-Project-Token']).take
  end

  def check_client_version
    # TODO: create a proper validation based on version range.
    return unless request.headers['X-Client-Version'].nil?

    raise CustomError.new(status: 422, message: I18n.t('popito.failure.incompatible_client'))
  end
end
