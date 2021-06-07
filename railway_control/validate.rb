# frozen_string_literal: true

class ValidateModuleException < RuntimeError
end

module Validate
  def valid?
    validate!
    true
  rescue ValidateModuleException
    raise
  rescue StandardError
    false
  end

  private

  def validate!
    raise ValidateModuleException, "Необходимо реализовать метод 'validate!'"
  end
end
