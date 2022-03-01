require_relative 'console'

class Xbox < Console
  attr_accessor :type

  def initialize(model, name, color)
    super
    @type = :xbox
  end
end
