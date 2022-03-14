# frozen_string_literal: true

require_relative 'console'
require_relative 'barcode'

class Controller
  attr_accessor :color, :enabled, :battery, :connected_console, :type, :barcode

  include Barcode

  def initialize(color)
    @color = color
    @enabled = false
    @battery = 100
    @connected_console = nil
  end

  def power_switch
    if @enabled
      disable_connecting_console
    else
      enabled_connecting_console
    end
  end

  def create_console_connection(console)
    return unless type == console.type

    if @connected_console == console
      @connected_console
    elsif @connected_console.nil?
      add_console_strategy(console)
    else
      change_console_strategy(console)
    end
  end

  private

  def enabled_connecting_console
    @enabled = true
    @connected_console.enabled = true if !@connected_console.nil? && @connected_console.enabled == false
  end

  def disable_connecting_console
    @enabled = false
    @connected_console.enabled = false if !@connected_console.nil? && @connected_console.enabled == true
  end

  def change_console(console)
    @connected_console.controllers_connected.delete(self)
    @connected_console = console
    @connected_console.add_controller(self)
    @connected_console
  end

  def add_console(console)
    @connected_console = console
    @connected_console.add_controller(self)
    @connected_console
  end

  def change_console_strategy(console)
    raise 'Console is not available' unless @connected_console.enabled == true

    change_console(console)
  end

  def add_console_strategy(console)
    raise 'Console is not available' unless console.enabled == true

    add_console(console)
  end
end
