require_relative 'controller'

class XboxController < Controller
  attr_accessor :type

  def initialize(color)
    super
    @type = :xbox
  end
end
