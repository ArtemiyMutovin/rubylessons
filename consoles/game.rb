class Game
  attr_accessor :name, :genre, :date, :platform

  def initialize(name, genre, date, platform)
    @name = name
    @genre = genre
    @date = date
    @platform = platform
  end
end
