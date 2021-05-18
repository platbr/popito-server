# frozen_string_literal: false

module FileRender
  extend ActiveSupport::Concern

  def render(context: nil, indent: nil, enable_comments: false)
    return data if render_engine_disabled?

    should_be('context', context, RenderContext)
    result = ''
    case render_engine
    when 'erb'
      result = erb_render(binding: context.context_binding)
    else
      raise NotImplementedError, 'This render engine is not implemented.'
    end
    unless indent.nil?
      new_result = ''
      result.lines.each do |line|
        new_result << indent + line
      end
      result = new_result
    end
    result = "#{comments_head}#{newline}" + result + "#{newline}#{comments_tail}" if enable_comments
    # puts result unless is_a?(FileResource::Fragment)
    result
  end

  private

  def erb_render(binding:)
    should_be('binding', binding, Binding)
    ERB.new(data, trim_mode: '-').result(binding)
  end

  def comments_head
    "#{comments_prefix}begin - #{comments_info}"
  end

  def comments_tail
    "#{comments_prefix}end - #{comments_info}"
  end

  def comments_info
    { type: type, id: id, label: label, path: path }.compact.map { |k, v| "#{k}:#{v} " }.join.strip
  end
end
