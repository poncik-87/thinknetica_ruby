require "./wagon"

class CargoWagon < Wagon
  attr_reader :occupied_volume

  def initialize(volume)
    @type, @volume, @occupied_volume = :cargo, volume, 0
  end

  def occupy_volume(volume)
    @occupied_volume += volume
    @occupied_volume = @volume if occupied_volume > @volume
  end

  def free_volume
    @volume - occupied_volume
  end

  def report
    "Свободный объем #{free_volume}, занятый объем #{occupied_volume}"
  end
end
