# frozen_string_literal: true

class CustomError < RuntimeError
  attr_accessor :status, :code

  def initialize(args)
    if args.respond_to?('[]')
      self.status = args[:status]
      self.code = args[:code] || 0
      super(args[:message])
    else
      super(args)
    end
  end
end
