# frozen_string_literal: true

require './instance_counter'
require './validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :name

  validate :name, :klass, klass: String
  validate :name, :presence

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
end
