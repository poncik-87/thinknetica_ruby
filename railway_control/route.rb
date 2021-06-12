# frozen_string_literal: true

require './instance_counter'
require './station'
require './validation'

class Route
  include InstanceCounter
  include Validation

  validate :start_station, :klass, klass: Station
  validate :end_station, :klass, klass: Station

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
end
