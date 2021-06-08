# frozen_string_literal: true

require './route'
require './station'
require './cargo_train'
require './cargo_wagon'
require './passenger_train'
require './passenger_wagon'

# rubocop:disable Metrics/ClassLength
class Menu
  def initialize
    @routes = []
    @stations = []
    @trains = []
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def menu
    puts 'Выберите действие:'
    puts '1. Создать маршрут'
    puts '2. Создать станцию'
    puts '3. Создать поезд'
    puts '4. Посмотреть маршруты'
    puts '5. Посмотреть станции'
    puts '6. Посмотреть поезда'
    puts '7. Посмотреть поезда на станции'
    puts '8. Прикрепить станцию к маршруту'
    puts '9. Открепить станцию от маршрута'
    puts '10. Назначить маршрут поезду'
    puts '11. Добавить вагон к поезду'
    puts '12. Отцепить вагон от поезда'
    puts '13. Посмотреть вагоны поезда'
    puts '14. Занять место в вагоне'
    puts '15. Переместить поезд'
    puts "для выхода введите 'стоп'"

    gets.chomp
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
  def sub_menu(choise)
    case choise
    when '1'
      make_route
    when '2'
      make_station
    when '3'
      make_train
    when '4'
      list_routes
    when '5'
      list_stations
    when '6'
      list_trains
    when '7'
      list_station_trains
    when '8'
      attach_station
    when '9'
      dettach_station
    when '10'
      attach_train
    when '11'
      attach_wagon
    when '12'
      dettach_wagon
    when '13'
      list_train_wagons
    when '14'
      occupy_train_wagon
    when '15'
      move_train
    else
      puts "Введено некорректное значение меню\n\n"
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength

  private

  def create_route(start_station, end_station)
    route = Route.new(start_station, end_station)
    @routes << route
    route
  end

  def route_by_number(number)
    @routes[number]
  end

  def create_station(name)
    station = Station.new(name)
    @stations << station
    station
  end

  def station_by_name(name)
    @stations.detect { |station| station.name == name }
  end

  def create_train(number, type)
    train = CargoTrain.new(number) if type == :cargo
    train = PassengerTrain.new(number) if type == :passenger

    @trains << train if train
    train
  end

  def ask_route_stations
    puts 'Введите название начальной станции'
    start_station_name = gets.chomp
    puts 'Введите название конечной станции'
    end_station_name = gets.chomp

    if start_station_name.empty? || end_station_name.empty?
      puts "Введены неверные значения, маршрут не создан\n\n"
      return []
    end

    [start_station_name, end_station_name]
  end

  def make_route
    start_station_name, end_station_name = ask_route_stations

    start_station = station_by_name(start_station_name)
    start_station ||= create_station(start_station_name)
    end_station = station_by_name(end_station_name)
    end_station ||= create_station(end_station_name)

    create_route(start_station, end_station)

    puts "Маршрут успешно создан\n\n"
  end

  def make_station
    puts 'Введите название станции'
    name = gets.chomp

    return "Введено некорректное имя, станция не создана\n\n" if name.empty?
    return "Станция с таким названием уже существует\n\n" if station_by_name(name)

    create_station(name)

    puts "Станция успешно создана\n\n"
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def make_train
    attempt = 0

    begin
      puts 'Введите номер поезда'
      number = gets.chomp

      raise 'Поезд с таким номером уже существует' if Train.find(number)

      puts 'Введите тип поезда: 1. грузовой 2. пассажирский'
      type_idx = gets.chomp.to_i
      type = %i[cargo passenger][type_idx - 1]

      train = create_train(number, type)

      raise 'Введен неверный тип поезда' unless train

      puts "Поезд создан\n\n"
    rescue StandardError => e
      attempt += 1
      puts "Поезд не создан. Причина: #{e.message}\n\n"

      return if attempt >= 3

      puts 'Попробуйте снова'
      retry
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def list_routes
    return puts "Список маршрутов пуст\n\n" if @routes.empty?

    puts 'Список маршрутов: '
    @routes.each do |route|
      puts "#{@routes.index(route)}. #{route.name}"
    end
    puts ''
  end

  def list_stations
    return puts "Список станций пуст\n\n" if @stations.empty?

    puts 'Список станций: '
    @stations.each { |station| puts station.name }
    puts ''
  end

  def list_trains
    return puts "Список поездов пуст\n\n" if @trains.empty?

    puts 'Список поездов: '
    @trains.each { |train| puts train.number }
    puts ''
  end

  def ask_route
    puts 'Введите номер маршрута'
    number = gets.chomp.to_i
    route = route_by_number(number - 1)
    return puts "Маршрут не найден\n\n" if route.nil?

    route
  end

  def ask_station
    puts 'Введите название станции'
    name = gets.chomp
    station = station_by_name(name)
    return puts "Станция не найдена\n\n" if station.nil?

    station
  end

  def ask_train
    puts 'Введите номер поезда'
    number = gets.chomp
    train = Train.find(number)
    return puts "Поезд не найден\n\n" if train.nil?

    train
  end

  def list_station_trains
    station = ask_station
    return if station.nil?
    return puts "На станции нет поездов\n\n" if station.trains.empty?

    puts "Список поездов на станции #{station.name}:"
    station.trains.each do |train|
      puts "Номер: #{train.number}, тип: #{train.type}, количество вагонов: #{train.wagons.length}"
    end
    puts ''
  end

  def attach_station
    route = ask_route
    return if route.nil?

    station = ask_station
    return if station.nil?

    if route.stations.any? { |route_station| route_station.name == station.name }
      return puts "Станция уже на маршруте\n\n"
    end

    route.add_mid_station(station)
    puts "Станция добавлена на маршрут\n\n"
  end

  def dettach_station
    route = ask_route
    return if route.nil?

    station = ask_station
    return if station.nil?

    deleted = route.remove_mid_station(station)
    return puts "Не удалось удалить станцию\n\n" if deleted.nil?

    puts "Станция удалена\n\n"
  end

  def attach_train
    route = ask_route
    return if route.nil?

    train = ask_train
    return if train.nil?

    train.route = route
    puts "Поезд прикреплен к маршруту\n\n"
  end

  def attach_wagon_if_cargo(train)
    return unless train.type == :cargo

    puts 'Введите объем вагона'
    volume = gets.chomp.to_i
    train.add_wagon(CargoWagon.new(volume))
  end

  def attach_wagon_if_passenger(train)
    return unless train.type == :passenger

    puts 'Введите количество мест в вагоне'
    seats = gets.chomp.to_i
    train.add_wagon(PassengerWagon.new(seats))
  end

  def attach_wagon
    train = ask_train
    return if train.nil?

    attach_wagon_if_cargo(train)
    attach_wagon_if_passenger(train)

    puts "Вагон добавлен к поезду\n\n"
  end

  def dettach_wagon
    train = ask_train
    return if train.nil?
    return puts "У поезда нет вагонов\n\n" if train.wagons.empty?

    train.delete_wagon(train.wagons.last)

    puts "Вагон удален\n\n"
  end

  def list_train_wagons
    train = ask_train
    return if train.nil?
    return puts "У поезда нет вагонов\n\n" if train.wagons.empty?

    puts "Список вагонов поезда #{train.number}:"
    train.each_wagon do |wagon, number|
      puts "#{number}: #{wagon.type}. #{wagon.report}"
    end
    puts ''
  end

  def occupy_cargo_wagon(wagon)
    return unless wagon.type == :cargo

    puts 'Введите значение объема'
    volume = gets.chomp.to_i
    wagon.occupy_volume(volume)
    puts "Объем занят\n\n"
  end

  def occupy_passenger_wagon(wagon)
    return unless wagon.type == :passenger

    wagon.occupy_seat
    puts "Место занято\n\n"
  end

  def ask_train_wagon(train)
    puts 'Введите номер вагона'
    number = gets.chomp.to_i
    train.wagons[number - 1]
  end

  def occupy_train_wagon
    train = ask_train
    return if train.nil?
    return puts "У поезда нет вагонов\n\n" if train.wagons.empty?

    wagon = ask_train_wagon(train)
    return puts "Неверный номер вагона\n\n" if wagon.nil?

    occupy_cargo_wagon(wagon)
    occupy_passenger_wagon(wagon)
  end

  def ask_train_direction
    puts 'В каком направлении переместить поезд: 1. вперед 2. назад'
    direction = gets.chomp.to_i
    return puts 'Введено неверное значение направления' unless [1, 2].include?(direction)

    direction
  end

  def move_train
    train = ask_train
    return if train.nil?

    direction = ask_train_direction

    train.move_next_station if direction == 1
    train.move_prev_station if direction == 2

    puts "Поезд перемещен\n\n"
  end
end
# rubocop:enable Metrics/ClassLength
