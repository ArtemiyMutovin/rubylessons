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
  end

  def delete_controller(controller)
    @controllers_connected.delete(controller)
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
      @library[:games] << content if @type == content.platform || content.platform == :multi
    else
      @library[:apps] << content
    end
  end

  def delete(content)
    if content.instance_of?(Game)
      @library[:games].delete(content) if @type == content.platform || content.platform == :multi
    else
      @library[:apps].delete(content)
    end
  end
end
