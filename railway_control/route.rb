# frozen_string_literal: true

require './instance_counter'
require './station'
require './validate'

class Route
  include InstanceCounter
  include Validate

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @mid_stations = []
    validate!
    register_instance
  end

  def name
    "#{@start_station.name} - #{@end_station.name}"
  end

  def add_mid_station(station)
    validate_station!(station)
    @mid_stations.push(station) unless @mid_stations.include?(station)
  end

  def remove_mid_station(station)
    @mid_stations.delete(station)
  end

  def stations
    [@start_station] + @mid_stations + [@end_station]
  end

  private

  def validate_station!(station)
    raise 'Некорректный тип станции' if station.class != Station
  end

  def validate!
    validate_station!(@start_station)
    validate_station!(@end_station)
  end
end
