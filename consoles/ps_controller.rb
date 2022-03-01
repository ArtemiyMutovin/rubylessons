require_relative 'controller'

class PSController < Controller
  attr_accessor :type

  def initialize(color)
    super
    @type = :playstation
  end
end
