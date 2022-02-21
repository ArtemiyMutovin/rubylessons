require_relative '../console'
require_relative '../controller'

RSpec.describe Console do
  subject(:console) { described_class.new(:series_x, :home_console, :black) }

  let(:controller) { Controller.new(:black) }

  describe '.add_controller' do
    it 'adds controller to console controllers' do
      console.add_controller(controller)
      expect(console.controllers_connected.count).to eq(1)
    end
  end

  describe '.delete_controller' do
    it 'deletes controller from console controllers' do
      console.add_controller(controller)
      console.delete_controller(controller)
      expect(console.controllers_connected.count).to eq(0)
    end
  end

  describe '.power_switch' do
    it 'turn on console when it already turn off' do
      console.enabled = false
      console.power_switch
      expect(console.enabled).to eq(true)
    end

    it 'turn off console when it already turn on' do
      console.enabled = true
      console.power_switch
      expect(console.enabled).to eq(false)
    end
  end

  describe '.wifi_connection_switch' do
    it 'turn on console wifi connection when it already turn off' do
      console.wifi_enabled = false
      console.wifi_connection_switch
      expect(console.wifi_enabled).to eq(true)
    end

    it 'turn off console wifi connection when it already turn on' do
      console.wifi_enabled = true
      console.wifi_connection_switch
      expect(console.wifi_enabled).to eq(false)
    end
  end

  describe '.add_game' do
    it 'adds game to library' do
      console.add_game('Mass Effect')
      expect(console.library[:games].count).to eq(1)
    end
  end

  describe '.add_app' do
    it 'adds app to library' do
      console.add_app('Spotify')
      expect(console.library[:apps].count).to eq(1)
    end
  end

  describe '.delete_game' do
    it 'deletes game from library' do
      console.add_game('Mass Effect')
      console.delete_game('Mass Effect')
      expect(console.library[:games].count).to eq(0)
    end
  end

  describe '.delete_app' do
    it 'deletes app from library' do
      console.add_app('Spotify')
      console.delete_app('Spotify')
      expect(console.library[:apps].count).to eq(0)
    end
  end
end
