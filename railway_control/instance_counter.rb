module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      @instances || 0
    end

    private
    #сеттер приватный, чтобы извне просто так нельзя было испортить каунтер
    def instances=(value)
      @instances = value
    end
  end

  module InstanceMethods
    private
    def register_instance
      self.class.send(:instances=, self.class.instances + 1)
    end
  end
end
