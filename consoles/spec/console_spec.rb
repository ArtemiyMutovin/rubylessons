require_relative '../console'
require_relative '../controller'
require_relative '../xbox_controller'
require_relative '../ps_controller'
require_relative '../game'
require_relative '../playstation'
require_relative '../xbox'

RSpec.describe Console do
  let(:playstation) { Playstation.new(:ps5, :home_console, :white) }
  let(:xbox) { Xbox.new(:series, :home_console, :black) }
  let(:psgame) { Game.new(:sifu, :fighting, 2022, :playstation) }
  let(:xbgame) { Game.new(:halo, :shooter, 2021, :xbox) }
  let(:multigame) { Game.new(:batman, :action,2014, :multi) }
  let(:xbox_controller) { XboxController.new(:blue) }
  let(:ps_controller) { PSController.new(:white) }

  describe '.add_controller' do
    context 'when controller.type is playstation' do
      context 'when console.type is playstation' do
        it 'adds controller to console controllers' do
          playstation.add_controller(ps_controller)
          expect(playstation.controllers_connected.count).to eq(1)
        end
      end
    end

    context 'when controller.type is xbox' do
      context 'when console.type is xbox' do
        it 'adds controller to console controllers' do
          xbox.add_controller(xbox_controller)
          expect(xbox.controllers_connected.count).to eq(1)
        end
      end
    end
  end

  describe '.delete_controller' do
    it 'deletes controller from console controllers' do
console.add_controller(xbox_controller)
console.delete_controller(xbox_controller)
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
    context 'when game.platform is playstation' do
      context 'console.type is playstation' do
        it 'adds game to library' do
          playstation.add_game(psgame)
          expect(playstation.library[:games].count).to eq(1)
        end
      end

      context 'console.type is xbox' do
        it "doesn't add game to library" do
          xbox.add_game(psgame)
          expect(xbox.library[:games].count).to eq(0)
        end
      end
    end

    context 'when game.platform is xbox' do
      context 'console.type is xbox' do
        it 'adds game to library' do
          xbox.add_game(xbgame)
          expect(xbox.library[:games].count).to eq(1)
        end
      end

      context 'console.type is playstation' do
        it "doesn't add game to library" do
          playstation.add_game(xbgame)
          expect(playstation.library[:games].count).to eq(0)
        end
      end
    end

    context 'when game.platform is multi' do
      context 'playstation' do
        it 'adds game to library' do
          playstation.add_game(multigame)
          expect(playstation.library[:games].count).to eq(1)
        end
      end
      context 'xbox' do
        it 'adds game to library' do
          xbox.add_game(multigame)
          expect(xbox.library[:games].count).to eq(1)
        end
      end
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
