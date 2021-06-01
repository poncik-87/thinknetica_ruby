require "./manufacturer"
require "./instance_counter"
require "./validate"

NUMBER_FORMAT = /^[а-я\d]{3}-?[а-я\d]{2}$/i

class Train
  include Manufacturer
  include InstanceCounter
  include Validate

  attr_reader :number, :speed, :current_station, :type, :wagons

  @@all = []

  def initialize(number = Random.new_seed.to_s)
    @number, @speed, @wagons = number, 0, []
    @@all << self
    validate!
    register_instance
  end

  def self.find(number)
    @@all.detect{|train| train.number == number}
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

  def delete_wagon(wagon)
    wagons.delete(wagon)
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

=begin
Интерфейс управления станцией поезда включает ф-ции move_prev_station, move_next_station.
Назначать станцию напрямую нельзя, т.к. это может привести к неконсистентному
состоянию (станция не относящаяся к пути, по которому движется поезд)
=end
  def station=(station)
    if (current_station == station)
      return
    end

    if (current_station)
      current_station.remove_train(self)
    end

    station.add_train(self)
    @current_station = station
  end

  private

=begin
prev_station, next_station являются приватными, т.к. логически определение
соседних станций не является функцией поезда, а значит не должно быть частью api
=end
  def prev_station
    @route.stations[@route.stations.find_index(current_station) - 1]
  end

  def next_station
    @route.stations[@route.stations.find_index(current_station) + 1]
  end

  def validate!
    errors = []
    errors << "Номер поезда должен быть строкой" if number.class != String
    errors << "Номер поезда должен быть непустым" if number.empty?
    errors << "Неверный формат номера поезда" if number !~ NUMBER_FORMAT
    raise errors.join('. ') if !errors.empty?
  end
end
