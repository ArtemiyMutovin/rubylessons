# frozen_string_literal: true

require_relative 'controller'
require_relative 'barcode'

class Console
  attr_accessor :color, :model, :name, :library, :controllers_connected,
                :enabled, :wifi_enabled, :type, :content, :number, :barcode

  include Barcode

  def initialize(model, name, color)
    @model = model
    @color = color
    @name = name
    @library = { games: [], apps: [] }
    @controllers_connected = []
    @enabled = false
    @wifi_enabled = false
  end

  def add_controller(controller)
    return unless @type == controller.type

    @controllers_connected << controller
    puts "#{controller} успешно добавлен"
  end

  def delete_controller(controller)
    @controllers_connected.delete(controller)
    puts "#{controller} успешно удален"
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

  def install(content)
    if content.instance_of?(Game)
      if @type == content.platform || content.platform == :multi
        @library[:games] << content
        puts "Игра #{content} добавлена в вашу библиотеку"
      end
    else
      @library[:apps] << content
      puts "Приложение #{content} добавлено в вашу библиотеку"
    end
  end

  def delete(content)
    if content.instance_of?(Game)
      if @type == content.platform || content.platform == :multi
        @library[:games].delete(content)
        puts "Игра #{content} удалена из вашей библиотеки"
      end
    else
      @library[:apps].delete(content)
      puts "Приложение #{content} удалено из вашей библиотеки"
    end
  end

  def show_library
    @library.each_with_index do |content, index|
      puts "#{index + 1}.#{content}"
    end
  end
end
