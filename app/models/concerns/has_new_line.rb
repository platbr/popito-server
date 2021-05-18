# frozen_string_literal: true

module HasNewLine
  extend ActiveSupport::Concern

  included do
    enum newline: { LF: 0, CRLF: 1, CR: 2 }, _prefix: :newline
    validates :newline, presence: true
  end

  def newline_char
    { LF: "\n", CRLF: "\r\n", CR: "\r" }[newline.to_sym]
  end
end
