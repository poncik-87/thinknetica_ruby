require "./instance_counter"

class Route
  include InstanceCounter

  def initialize(start_station, end_station)
    @start_station, @end_station, @mid_stations = start_station, end_station, []
    register_instance
  end

  def name
    "#{@start_station.name} - #{@end_station.name}"
  end

  def add_mid_station(station)
    @mid_stations.push(station) if !@mid_stations.include?(station)
  end

  def remove_mid_station(station)
    @mid_stations.delete(station)
  end

  def stations
    [@start_station] + @mid_stations + [@end_station]
  end
end
