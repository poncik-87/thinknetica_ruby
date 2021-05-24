class Train
  attr_reader :speed, :carriage_count, :current_station

  def initialize(number, type, carriage_count)
    @number, @type, @carriage_count, @speed = number, type, carriage_count, 0
  end

  def increase_speed(value)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def attach_carriage
    self.carriage_count += 1 if speed == 0
  end

  def dettach_carriage
    self.carriage_count -= 1 if speed == 0 && carriage_count > 0
  end

  def route=(route)
    @route = route
    self.station = route.stations.first
  end

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

  def move_prev_station
    self.station = prev_station
  end

  def move_next_station
    self.station = next_station
  end

  def prev_station
    @route.stations[@route.stations.find_index(current_station) - 1]
  end

  def next_station
    @route.stations[@route.stations.find_index(current_station) + 1]
  end
end
