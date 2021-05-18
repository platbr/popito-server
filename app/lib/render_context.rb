# frozen_string_literal: false

class RenderContext
  DELAYED_PATTERN = /^{{(?<key>\w+)(?<separator>:)?(?<default>\w+)?}}$/
  CLIENT_BUILD_CONFIG_EXCLUSIVE_KEYS = %w[ENVIRONMENT IMAGE_TAG].freeze

  include CustomSanitizer
  attr_accessor :params

  def initialize(project:, client_build_config:)
    should_be('project', project, Project)
    should_be('client_build_config', client_build_config, Hash)

    if client_build_config['ENVIRONMENT'].blank?
      raise CustomError.new(status: 422,
                            message: I18n.t('popito.failure.empty_environment'))
    end

    @environment = project.environments.where(label: client_build_config['ENVIRONMENT']).take
    if @environment.nil?
      raise CustomError.new(status: 422,
                            message: I18n.t('popito.failure.invalid_environment',
                                            environment: client_build_config['ENVIRONMENT']))
    end

    @client_build_config = client_build_config.deep_stringify_keys
    @project = project
    self.params = {}
  end

  def project_label
    @project.label
  end

  def available_environments
    @available_environments ||= @project.environments.pluck(:label)
  end

  def context_binding
    binding
  end

  def get_value(key, default: nil, allow_null: false, allow_empty: false, skip_params: false)
    value = search_value(key, skip_params: skip_params) || default
    raise "The build_config \"#{key}\" was null and allow_null is false." if value.nil? && !allow_null
    raise "The build_config \"#{key}\" was empty and allow_empty is false." if value == '' && !allow_empty

    value
  end

  def get_param_value(key, default: nil, allow_null: false, allow_empty: false)
    value = search_in_params(key) || default
    raise "The fragment param \"#{key}\" was null and allow_null is false." if value.nil? && !allow_null
    raise "The fragment param \"#{key}\" was empty and allow_empty is false." if value == '' && !allow_empty

    # {{SOMETHING}} values will be evaluated against the build_params.
    resolve_delayed_params(value)
  end

  def to_hash
    { project_label: project_label,
      build_config: build_config.to_h,
      env_build_config: env_build_config.to_h,
      project_build_config: project_build_config.to_h,
      template_build_config: template_build_config.to_h }.deep_stringify_keys
  end

  private

  def resolve_delayed_params(value)
    return resolve_delayed_params_hash(value) if value.is_a?(Hash)
    return evaluate_delayed_param(value) unless value.is_a?(Enumerable)

    value.map do |element|
      resolve_delayed_params(element)
    end
  end

  def resolve_delayed_params_hash(a_hash)
    a_hash.each { |k, v| a_hash[k] = resolve_delayed_params(v) }
  end

  def evaluate_delayed_param(value)
    matched = value.to_s.match(DELAYED_PATTERN)
    return value if matched.nil?

    get_value(matched['key'], default: matched['default'], skip_params: true)
  end

  attr_reader :build_config

  def project_build_config
    @project_build_config ||= @project.build_config.deep_stringify_keys
  end

  def template_build_config
    @template_build_config ||= @project.template.build_config.deep_stringify_keys
  end

  def env_build_config
    @env_build_config ||= @environment.build_config.deep_stringify_keys
  end

  def search_value(key, skip_params: false)
    return @client_build_config[key] if CLIENT_BUILD_CONFIG_EXCLUSIVE_KEYS.include?(key)
    return search_except_in_params(key) if skip_params

    search_in_all(key)
  end

  def search_in_all(key)
    @client_build_config[key] || params[key] || env_build_config[key] || project_build_config[key] || template_build_config[key]
  end

  def search_except_in_params(key)
    @client_build_config[key] || env_build_config[key] || project_build_config[key] || template_build_config[key]
  end

  def search_in_params(key)
    raise "The #{key} var can't be used in a parameter." if CLIENT_BUILD_CONFIG_EXCLUSIVE_KEYS.include?(key)

    params[key]
  end

  def render_fragment(label:, global: false, params: nil, indent: nil, enable_comments: true)
    fragment = FileResource::Fragment.where(owner: nil, label: label).take if global
    fragment ||= @project.fragments.or(@project.template.fragments).where(label: label).order(:owner_priority).take
    if fragment.nil?
      raise CustomError.new(status: 422,
                            message: I18n.t('popito.failure.invalid_fragment', fragment: label))
    end

    self.params = params.deep_stringify_keys if params.present?

    fragment.render(context: self, indent: indent, enable_comments: enable_comments)
  end

  def add_indent(value, indent: '', strip_yaml_header: false, skip_first_line: false)
    result = ''
    value.lines.each_with_index do |line, index|
      next if index.zero? && line == "---\n" && strip_yaml_header

      result << if index.zero? && skip_first_line
                  line
                else
                  indent + line
                end
    end
    result.rstrip
  end

  def render_object(value, indent: '')
    add_indent(value.to_yaml, indent: indent, strip_yaml_header: true)
  end
end
