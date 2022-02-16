# frozen_string_literal: true

require_relative 'console'

class Controller
  attr_accessor :color, :enabled, :battery, :connected_console

  def initialize(color)
    @color = color
    @enabled = false
    @battery = 100
    @connected_console = nil
  end

  def power_switch
    if @enabled
      disable_connecting_xbox
    else
      enabled_connecting_xbox
    end
  end

  def create_console_connection(xbox)
    if @connected_console == xbox
      puts 'Вы уже подключены'
    elsif @connected_console.nil?
      add_xbox_strategy(xbox)
    else
      change_xbox_strategy(xbox)
    end
  end

  private

  def enabled_connecting_xbox
    @enabled = true
    @connected_console.enabled = true if !@connected_console.nil? && @connected_console.enabled == false
    puts 'Консоль и геймпад включены'
  end

  def disable_connecting_xbox
    @enabled = false
    @connected_console.enabled = false if !@connected_console.nil? && @connected_console.enabled == true
    puts 'Консоль и геймпад отключены'
  end

  def change_console(xbox)
    @connected_console.controllers_connected.delete(self)
    @connected_console = xbox
    @connected_console.add_controller(self)
    puts "Ваш геймпад подключен к консоли #{xbox.name}"
  end

  def add_console(xbox)
    @connected_console = xbox
    @connected_console.add_controller(self)
    puts "Ваш геймпад подключен к консоли #{xbox.name}"
  end

  def change_xbox_strategy(xbox)
    if @connected_console.enabled == true
      change_console(xbox)
    else
      puts 'Консоль к которой вы хотите подключиться не найдена'
    end
  end

  def add_xbox_strategy(xbox)
    if xbox.enabled == true
      add_console(xbox)
    else
      puts 'Консоль к которой вы хотите подключиться не найдена'
    end
  end
end
