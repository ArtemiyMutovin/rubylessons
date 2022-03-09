module Barcode
  def add_barcode(code)
    self.barcode = code
  end

  def show_barcode
    self.barcode
  end

  attr_accessor :barcode
end

class App
  include Barcode
  attr_accessor :name

  def self.add_barcode(number)
    @barcode = number
  end

  def initialize(name)
    @name = name
  end
end
