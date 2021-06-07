# frozen_string_literal: true

require './train'

class PassengerTrain < Train
  def initialize(number)
    super(number)

    @type = :passenger
  end
end
