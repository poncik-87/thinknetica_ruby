require "./instance_counter"
require "./validate"

class Station
  include InstanceCounter
  include Validate

  attr_reader :trains, :name

  @@all = []

  def initialize(name)
    @name, @trains = name, []
    @@all << self
    validate!
    register_instance
  end

  def self.all
    @@all
  end

  def add_train(train)
    trains.push (train) if !trains.include?(train)
  end

  def remove_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.filter {|train| train.type == type}
  end

  private

  def validate!
    errors = []
    errors << "Имя должно быть строкой" if name.class != String
    errors << "Имя должно быть непустым" if name.empty?
    raise errors.join('. ') if !errors.empty?
  end
end
