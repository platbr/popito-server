# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper

  rescue_from Exception do |err|
    render_error(err)
  end

  rescue_from CustomError do |err|
    render_error(err)
  end

  private

  def render_error(err)
    code = err.respond_to?(:code) ? (err.code || 0) : 0
    status = err.respond_to?(:status) ? (err.status || 500) : 500
    render json: { code: code, message: err.message || I18n.t('popito.failure.generic_error') }, status: status
    if status >= 500
      Rails.logger.error err.message
      Rails.logger.error err.backtrace.join("\n")
    end
    nil
  end
end
