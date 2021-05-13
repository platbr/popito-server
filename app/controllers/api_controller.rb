# frozen_string_literal: true

class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_client_version
  before_action :check_project

  def check_project
    raise CustomError.new(status: 403, message: 'Invalid token.') if current_project.nil?
  end

  def current_project
    return nil if request.headers['X-Project-Token'].nil?

    @current_project ||= Project.where(token: request.headers['X-Project-Token']).take
  end

  def check_client_version
    return unless request.headers['X-Client-Version'].nil?

    raise CustomError.new(status: 422, message: 'Your client version is not allowed, use a compatible version.')
  end
end
