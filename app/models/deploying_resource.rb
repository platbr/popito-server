class DeployingResource < ApplicationRecord
  belongs_to :owner, polymorphic: true
  belongs_to :deploying_model, class_name: 'FileResource::DeployingModel'
  validates :path, presence: true

  # TODO: organizar o codigo rem uma classe classe RenderComments
  # para evitar codigo repetido

  def render(context:, enable_comments: false)
    context.params = params
    result = deploying_model.render(context: context, enable_comments: enable_comments)
    result = "#{comments_head}#{newline}" + result + "#{newline}#{comments_tail}" if enable_comments
    result
  end

  private

  def comments
    deploying_model.comments
  end

  def newline
    deploying_model.newline
  end

  def comments_head
    "#{comments}begin - #{comments_info}"
  end

  def comments_tail
    "#{comments}end - #{comments_info}"
  end

  def comments_info
    "type:DeployingResource id:#{id} path:#{path}"
  end
end
