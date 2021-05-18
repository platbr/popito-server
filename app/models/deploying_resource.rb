class DeployingResource < ApplicationRecord
  belongs_to :owner, polymorphic: true
  belongs_to :deploying_model, class_name: 'FileResource::DeployingModel'
  validates :path, presence: true
  validates :chmod, presence: true
  alias_attribute :name, :label

  # TODO: organizar o codigo rem uma classe classe RenderComments
  # para evitar codigo repetido

  def render(context:, enable_comments: false)
    context.params = params
    result = deploying_model.render(context: context, enable_comments: enable_comments)
    result = "#{comments_head}#{newline_char}" + result + "#{newline_char}#{comments_tail}" if enable_comments
    result
  end

  alias_attribute :name, :path

  private

  def comments
    deploying_model.comments
  end

  def newline_char
    deploying_model.newline_char
  end

  def comments_head
    "#{comments_prefix}begin - #{comments_info}"
  end

  def comments_tail
    "#{comments_prefix}end - #{comments_info}"
  end

  def comments_info
    "type:DeployingResource id:#{id} path:#{path}"
  end

  amoeba do
    enable
  end
end
