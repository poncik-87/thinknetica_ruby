require "./instance_counter"
require "./station"
require "./validate"

class Route
  include InstanceCounter
  include Validate

  def initialize(start_station, end_station)
    @start_station, @end_station, @mid_stations = start_station, end_station, []
    validate!
    register_instance
  end

  def name
    "#{@start_station.name} - #{@end_station.name}"
  end

  def add_mid_station(station)
    validateStation!(station)
    @mid_stations.push(station) if !@mid_stations.include?(station)
  end

  def remove_mid_station(station)
    @mid_stations.delete(station)
  end

  def stations
    [@start_station] + @mid_stations + [@end_station]
  end

  private
  def validateStation!(station)
    raise "Некорректный тип станции" if station.class != Station
  end

  def validate!
    validateStation!(@start_station)
    validateStation!(@end_station)
  end
end
