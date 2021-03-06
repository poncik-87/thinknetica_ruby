# frozen_string_literal: true

require './wagon'

class PassengerWagon < Wagon
  attr_reader :occupied_seats

  def initialize(seats)
    super

    @type = :passenger
    @seats = seats
    @occupied_seats = 0
  end

  def occupy_seat
    @occupied_seats += 1 if @seats > occupied_seats
  end

  def free_seats
    @seats - occupied_seats
  end

  def report
    "Свободные места #{free_seats}, занятые места #{occupied_seats}"
  end
end
