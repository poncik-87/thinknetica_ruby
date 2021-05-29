class Station
  attr_reader :trains, :name

  @@all = []

  def initialize(name)
    @name, @trains = name, []
    @@all << self
  end

  def self.all
    @@all
  end

  def add_train(train)
    trains.push (train) if !trains.include?(train)
  end

  def remove_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.filter {|train| train.type == type}
  end
end
