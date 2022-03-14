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
    @controllers_connected
  end

  def delete_controller(controller)
    @controllers_connected.delete(controller)
    @controllers_connected
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
        @library
      end
    else
      @library[:apps] << content
      @library
    end
  end

  def delete(content)
    if content.instance_of?(Game)
      if @type == content.platform || content.platform == :multi
        @library[:games].delete(content)
        @library
      end
    else
      @library[:apps].delete(content)
      @library
    end
  end
end
