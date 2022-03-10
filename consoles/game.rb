require_relative 'barcode'

class Game
  attr_accessor :name, :genre, :date, :platform, :barcode

  include Barcode

  @instances = {}

  def initialize(name, genre, date, platform)
    @name = name
    @genre = genre
    @date = date
    @platform = platform.to_sym
  end
end
