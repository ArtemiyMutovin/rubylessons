# frozen_string_literal: true

require_relative 'controller'

class Console
  attr_accessor :color, :model, :name, :library, :controllers_connected, :enabled, :wifi_enabled, :apps, :games, :type

  def initialize(model, name, color)
    @model = model
    @color = color
    @name = name
    @library = { games: [], apps: [] }
    @controllers_connected = []
    @enabled = false
    @wifi_enabled = false
  end

  def add_controller(gamepad)
    @controllers_connected << gamepad
  end

  def delete_controller(gamepad)
    @controllers_connected.delete(gamepad)
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

  def add_app(app)
    @library[:apps] << app
    puts "#{app} добавлен в вашу библиотеку"
  end

  def delete_app(app)
    @library[:apps].delete(app)
    puts "#{app} удален из вашей библиотеки"
  end

  def add_game(game)
    return unless @type == game.platform || game.platform == :multi

    @library[:games] << game
    puts "#{game} добавлен в вашу библиотеку"
    # if @type == game.platform || game.platform == :multi
    #   @library[:games] << game
    #   puts "#{game} добавлен в вашу библиотеку"
    # end
  end

  def delete_game(game)
    @library[:games].delete(game)
    puts "#{game} удален из вашей библиотеки"
  end

  def show_library
    @library.each_with_index do |content, index|
      puts "#{index + 1}.#{content}"
    end
  end
end
