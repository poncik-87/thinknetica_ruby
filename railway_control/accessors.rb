# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_history = history_name(name).to_sym

        # геттер
        define_method(name) { instance_variable_get(var_name) }

        # сеттер
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          write_history(name, value)
        end

        # геттер истории
        define_method("#{name}_history".to_sym) { instance_variable_get(var_history) }
      end
    end

    def strong_attr_accessor(name, klass)
      var_name = "@#{name}".to_sym

      # геттер
      define_method(name) { instance_variable_get(var_name) }

      # сеттер
      define_method("#{name}=".to_sym) do |value|
        raise "class missmatch while try to set #{name}" unless value.instance_of?(klass)

        instance_variable_set(var_name, value)
      end
    end

    private

    def history_name(name)
      "@#{name}_history"
    end

    def write_history(name, value)
      var_history = history_name(name).to_sym

      history = instance_variable_get(var_history) || []
      history << value
      instance_variable_set(var_history, history)
    end
  end
end
