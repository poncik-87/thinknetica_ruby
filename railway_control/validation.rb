# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    def validations
      @validations || []
    end

    def validate(name, type, options = {})
      @validations ||= []
      @validations << ["@#{name}".to_sym, type, options]
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue ValidateModuleException
      raise
    rescue StandardError
      false
    end

    def validate!
      errors = []

      self.class.validations.each do |validation|
        name, type, options = validation
        error = send(type, name, options)
        errors << error unless error.nil?
      end

      raise errors.join('; ') unless errors.empty?
    end

    private

    def presence(name, _)
      value = instance_variable_get(name)
      "#{name}: presence validation fail" if value.nil? || (value.respond_to?(:empty?) && value.empty?)
    end

    def format(name, options)
      value = instance_variable_get(name)
      "#{name}: format validation fail" if value !~ options[:pattern]
    end

    def klass(name, options)
      value = instance_variable_get(name)
      "#{name}: class validation fail" unless value.instance_of?(options[:klass])
    end
  end
end
