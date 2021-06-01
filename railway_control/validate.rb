class ValidateModuleException < Exception
end

module Validate
  def valid?
    validate!
    true
  rescue ValidateModuleException
    raise
  rescue
    false
  end

  private

  def validate!
    raise ValidateModuleException.new "Необходимо реализовать метод 'validate!'"
  end
end
