# frozen_string_literal: true

require_relative 'controller'

class Console
  attr_accessor :color, :model, :name, :library, :controllers_connected, :enabled, :wifi_enabled

  def initialize(model, name, color)
    @model = model
    @color = color
    @name = name
    @library = []
    @controllers_connected = []
    @enabled = false
    @wifi_enabled = false
  end

  def add_controller(gamepad)
    @controllers_connected << gamepad
  end

  def power_switch
    if @enabled
      @enabled = false
      'Консоль выключена'
    else
      @enabled = true
      'Консоль включена'
    end
  end

  def controllers_on
    @controllers_connected.each_with_index do |controller, index|
      puts 'Геймпады успешно синхронизированы'
      puts "#{index + 1}. #{controller}"
    end
  end

  def wifi_connection_switch
    if @wifi_enabled
      @wifi_enabled = false
      'Соединение выключено'
    else
      @wifi_enabled = true
      'Соединение включено'
    end
  end

  def add_game(game)
    @library << game
    puts "Игра #{game} добавлена в вашу библиотеку игр"
  end

  def delete_game(game)
    @library.delete(game)
    puts "Игра #{game} удалена из вашей библиотеки игр"
  end

  def show_library
    @library.each_with_index do |game, index|
      puts "#{index + 1}.#{game}"
    end
  end
end
