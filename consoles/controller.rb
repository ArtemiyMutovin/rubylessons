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

  def connect_xbox(xbox)
    if @connected_console == xbox
      puts 'Вы уже подключены'
    elsif !@connected_console.nil?
      change_xbox_logic(xbox)
    else
      add_xbox_strategy(xbox)
    end
  end

  private

  def enabled_connecting_xbox
    @enabled = true
    @connected_console.console_enabled = true if !@connected_console.nil? && @connected_console.console_enabled == false
    puts 'Консоль и геймпад включены'
  end

  def disable_connecting_xbox
    @enabled = false
    @connected_console.console_enabled = false if !@connected_console.nil? && @connected_console.console_enabled == true
    puts 'Консоль и геймпад отключены'
  end

  def connect_to_xbox(xbox)
    if @connected_console.console_enabled == true
      change_console(xbox)
    else
      puts 'Консоль к которой вы хотите подключиться не найдена'
    end
  end

  def change_console(xbox)
    @connected_console.controllers_connected.delete(self)
    @connected_console = xbox
    @connected_console.controllers_connected.push(self)
    puts "Ваш геймпад подключен к консоли #{xbox.name}"
  end

  def add_console(xbox)
    @connected_console = xbox
    @connected_console.controllers_connected.push(self)
    puts "Ваш геймпад подключен к консоли #{xbox.name}"
  end

  def change_xbox_logic(xbox)
    puts 'Геймпад уже подключен к консоли'
    puts 'Хотите ли подключить геймпад к другой консоли?'
    answer = gets.chomp
    if answer == 'да'
      connect_to_xbox(xbox)
    else
      puts 'Геймпад имеет текущую консоль'
    end
  end

  def add_xbox_strategy(xbox)
    if xbox.console_enabled == true
      add_console(xbox)
    else
      puts 'Консоль к которой вы хотите подключиться не найдена'
    end
  end
end
