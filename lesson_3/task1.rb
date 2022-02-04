class Station
  attr_reader :name , :trains

  def initialize (name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def return_type(type)
    @trains.select do|train|
       train.type == type
    end
  end

  def delete_train(train)
    @trains.delete(train)
  end
end

class Train
  attr_reader :type , :number , :wagons, :current_station, :current_speed

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @current_speed = 0
  end

  def start(speed)
    @current_speed += speed
  end

  def stop(speed)
    @current_speed = @current_speed - speed
  end

  def current_speed
    @current_speed
  end

  def add_wagon
    @wagons += 1 if @current_speed == 0
  end

  def delete_wagon
    @wagons -= 1 if @current_speed == 0
  end

  def getting_route(route)
    @route = route
    @current_station = @route.stations.first
  end

  def move_train
    current_index = @route.stations.find_index(@current_station)
    @current_station = @route.stations[current_index + 1]
  end
end

class Route

  attr_reader :stations

  def initialize (first , last)
    @stations = [first, last]
  end

  def add_midway(station)
    @stations.insert(-2, station)
  end

  def delete_midway(station)
    @stations.delete(station)
  end

  def show_stations
    puts @stations
  end
end


