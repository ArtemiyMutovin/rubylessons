# frozen_string_literal: true

require_relative 'console'

class Controller
  attr_accessor :color, :enabled, :battery, :connected_console, :type

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
      puts 'Вы уже подключены'
    elsif @connected_console.nil?
      add_console_strategy(console)
    else
      change_console_strategy(console)
    end
  end
end

  private

def enabled_connecting_console
  @enabled = true
  @connected_console.enabled = true if !@connected_console.nil? && @connected_console.enabled == false
  puts 'Консоль и геймпад включены'
end

def disable_connecting_console
  @enabled = false
  @connected_console.enabled = false if !@connected_console.nil? && @connected_console.enabled == true
  puts 'Консоль и геймпад отключены'
end

def change_console(console)
  @connected_console.controllers_connected.delete(self)
  @connected_console = console
  @connected_console.add_controller(self)
  puts "Ваш геймпад подключен к консоли #{console.name}"
end

def add_console(console)
  @connected_console = console
  @connected_console.add_controller(self)
  puts "Ваш геймпад подключен к консоли #{console.name}"
end

def change_console_strategy(console)
  if @connected_console.enabled == true
    change_console(console)
  else
    puts 'Консоль к которой вы хотите подключиться не найдена'
  end
end

def add_console_strategy(console)
  if console.enabled == true
    add_console(console)
  else
    puts 'Консоль к которой вы хотите подключиться не найдена'
  end
end
