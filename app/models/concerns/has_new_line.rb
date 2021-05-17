# frozen_string_literal: true

module HasNewLine
  extend ActiveSupport::Concern

  included do
    enum newline: { LF: 0, CRLF: 1, CR: 2 }, _prefix: :newline
    validates :newline, presence: true
  end

  def newline_char
    case newline
    when 'LF'
      return "\n"
    when 'CRLF'
      return "\r\n"
    when 'CR'
      return "\r"
    end
  end
end
