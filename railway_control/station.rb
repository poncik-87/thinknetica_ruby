# frozen_string_literal: true

require './instance_counter'
require './validate'

class Station
  include InstanceCounter
  include Validate

  attr_reader :trains, :name

  # rubocop:disable Style/ClassVars
  @@all = []
  # rubocop:enable Style/ClassVars

  def initialize(name)
    @name = name
    @trains = []
    @@all << self
    validate!
    register_instance
  end

  def self.all
    @@all
  end

  def add_train(train)
    trains.push(train) unless trains.include?(train)
  end

  def remove_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.filter { |train| train.type == type }
  end

  private

  def validate!
    errors = []
    errors << 'Имя должно быть строкой' if name.class != String
    errors << 'Имя должно быть непустым' if name.empty?
    raise errors.join('. ') unless errors.empty?
  end
end
