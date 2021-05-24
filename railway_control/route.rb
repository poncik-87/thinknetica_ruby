class Route
  def initialize(start_station, end_station)
    @start_station, @end_station, @mid_stations = start_station, end_station, []
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
