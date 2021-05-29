require "./manufacturer"

class Wagon
  include Manufacturer

  attr_reader :type
end
