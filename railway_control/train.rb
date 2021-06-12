# frozen_string_literal: true

require './manufacturer'
require './instance_counter'
require './validation'

NUMBER_FORMAT = /^[а-я\d]{3}-?[а-я\d]{2}$/i.freeze

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_reader :number, :speed, :current_station, :type, :wagons

  validate :number, :klass, klass: String
  validate :number, :presence
  validate :number, :format, pattern: NUMBER_FORMAT

  # rubocop:disable Style/ClassVars
  @@all = []
  # rubocop:enable Style/ClassVars

  def initialize(number = Random.new_seed.to_s)
    @number = number
    @speed = 0
    @wagons = []
    @@all << self
    validate!
    register_instance
  end

  def self.find(number)
    @@all.detect { |train| train.number == number }
  end

  def increase_speed(value)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    wagons.push(wagon) if wagon.type == type && !wagons.include?(wagon)
  end

  def each_wagon
    @wagons.each_index { |index| yield(@wagons[index], index) }
  end

  def route=(route)
    @route = route
    self.station = route.stations.first
  end

  def move_prev_station
    self.station = prev_station
  end

  def move_next_station
    self.station = next_station
  end

  protected

  # Интерфейс управления станцией поезда включает ф-ции move_prev_station, move_next_station.
  # Назначать станцию напрямую нельзя, т.к. это может привести к неконсистентному
  # состоянию (станция не относящаяся к пути, по которому движется поезд)
  def station=(station)
    return if current_station == station

    current_station&.remove_train(self)

    station.add_train(self)
    @current_station = station
  end

  private

  # prev_station, next_station являются приватными, т.к. логически определение
  # соседних станций не является функцией поезда, а значит не должно быть частью api
  def prev_station
    @route.stations[@route.stations.find_index(current_station) - 1]
  end

  def next_station
    @route.stations[@route.stations.find_index(current_station) + 1]
  end
end
