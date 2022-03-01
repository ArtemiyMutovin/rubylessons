require_relative 'console'

class Playstation < Console
  attr_accessor :type

  def initialize(model, name, color)
    super
    @type = :playstation
  end
end
