require_relative 'barcode'

class App
  attr_accessor :name, :barcode

  include Barcode

  @instances = {}

  def initialize(name)
    @name = name
  end
end
