module Barcode
  def add_barcode(code)
    self.barcode = code
  end

  def show_barcode
    self.barcode
  end

  attr_accessor :barcode
end

  class Game
    include Barcode
  attr_accessor :name, :genre, :date, :platform


  def initialize(name, genre, date, platform)
    @name = name
    @genre = genre
    @date = date
    @platform = platform.to_sym
  end
end
