require_relative '../console'
require_relative '../controller'
require_relative '../xbox_controller'
require_relative '../ps_controller'
require_relative '../game'
require_relative '../app'
require_relative '../playstation'
require_relative '../xbox'
require_relative '../barcode'

RSpec.describe Console do
  let(:playstation) { Playstation.new(:ps5, :home_console, :white) }
  let(:xbox) { Xbox.new(:series, :home_console, :black) }
  let(:psgame) { Game.new(:sifu, :fighting, 2022, :playstation) }
  let(:xbgame) { Game.new(:halo, :shooter, 2021, :xbox) }
  let(:multigame) { Game.new(:batman, :action, 2014, :multi) }
  let(:xbox_controller) { XboxController.new(:blue) }
  let(:ps_controller) { PSController.new(:white) }
  let(:app1) { App.new(:spotify) }

  describe '.add_barcode' do
    context 'when object is console' do
      it 'adds barcode to console' do
        xbox.add_barcode(10)
        expect(xbox.barcode).to eq(10)
      end
    end
  end

    describe '.find_barcode' do
      it 'finds barcode' do
        xbox.add_barcode(10)
        expect(xbox.class.find(10)).to eq(xbox)
      end
    end

  describe '.add_controller' do
    context 'when controller.type is playstation' do
      context 'when console.type is playstation' do
        it 'adds controller to console controllers' do
          playstation.add_controller(ps_controller)
          expect(playstation.controllers_connected.count).to eq(1)
        end
      end

      context 'when console.type is xbox' do
        it "doesn't adds controller to console controllers" do
          xbox.add_controller(ps_controller)
          expect(xbox.controllers_connected.count).to eq(0)
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

      context 'when console.type is playstation' do
        it "doesn't adds controller to console controllers" do
          playstation.add_controller(xbox_controller)
          expect(playstation.controllers_connected.count).to eq(0)
        end
      end
    end
  end

  describe '.delete_controller' do
    context 'when controller.type is playstation' do
      context 'when console.type is playstation' do
        it 'deletes controller from console controllers' do
          playstation.add_controller(ps_controller)
          playstation.delete_controller(ps_controller)
          expect(playstation.controllers_connected.count).to eq(0)
        end
      end
    end

    context 'when controller.type is xbox' do
      context 'when console.type is xbox' do
        it 'deletes controller from console controllers' do
          xbox.add_controller(xbox_controller)
          xbox.delete_controller(xbox_controller)
          expect(xbox.controllers_connected.count).to eq(0)
        end
      end
    end
  end

  describe '.power_switch' do
    it 'turn on console when it already turn off' do
      xbox.enabled = false
      xbox.power_switch
      expect(xbox.enabled).to eq(true)
    end

    it 'turn off console when it already turn on' do
      xbox.enabled = true
      xbox.power_switch
      expect(xbox.enabled).to eq(false)
    end
  end

  describe '.wifi_connection_switch' do
    it 'turn on console wifi connection when it already turn off' do
      xbox.wifi_enabled = false
      xbox.wifi_connection_switch
      expect(xbox.wifi_enabled).to eq(true)
    end

    it 'turn off console wifi connection when it already turn on' do
      xbox.wifi_enabled = true
      xbox.wifi_connection_switch
      expect(xbox.wifi_enabled).to eq(false)
    end
  end

  describe '.install' do
    context 'when content.class is game' do
      context 'when game.platform is playstation' do
        context 'when console.type is playstation' do
          it 'adds game to library' do
            playstation.install(psgame)
            expect(playstation.library[:games].count).to eq(1)
          end
        end

        context 'when console.type is xbox' do
          it "doesn't add game to library" do
            xbox.install(psgame)
            expect(xbox.library[:games].count).to eq(0)
          end
        end
      end

      context 'when game.platform is xbox' do
        context 'when console.type is xbox' do
          it 'adds game to library' do
            xbox.install(xbgame)
            expect(xbox.library[:games].count).to eq(1)
          end
        end

        context 'when console.type is playstation' do
          it "doesn't add game to library" do
            playstation.install(xbgame)
            expect(playstation.library[:games].count).to eq(0)
          end
        end
      end

      context 'when game.platform is multi' do
        context 'when console is playstation' do
          it 'adds game to library' do
            playstation.install(multigame)
            expect(playstation.library[:games].count).to eq(1)
          end
        end

        context 'when console is xbox' do
          it 'adds game to library' do
            xbox.install(multigame)
            expect(xbox.library[:games].count).to eq(1)
          end
        end
      end
    end

    context 'when content.class is app' do
      context 'when console is playstation' do
        it 'adds app to library' do
          playstation.install(app1)
          expect(playstation.library[:apps].count).to eq(1)
        end
      end

      context 'when console is xbox' do
        it 'adds app to library' do
          xbox.install(app1)
          expect(xbox.library[:apps].count).to eq(1)
        end
      end
    end
  end

  describe '.delete' do
    context 'when content.class is Game' do
      context 'when console is playstation' do
        context 'when game.platform is playstation' do
          it 'deletes game from playstation library' do
            playstation.install(psgame)
            playstation.delete(psgame)
            expect(playstation.library[:games].count).to eq(0)
          end
        end
      end

      context 'when console.type is playstation' do
        context 'when game.platform is multi' do
          it 'deletes game from playstation library' do
            playstation.install(multigame)
            playstation.delete(multigame)
            expect(playstation.library[:games].count).to eq(0)
          end
        end
      end

      context 'when console is xbox' do
        context 'when game.platform is xbox'
        it 'deletes game from xbox library' do
          xbox.install(xbgame)
          xbox.delete(xbgame)
          expect(xbox.library[:games].count).to eq(0)
        end
      end

      context 'when console.type is xbox' do
        context 'when game.platform is multi' do
          it 'deletes game from xbox library' do
            xbox.install(multigame)
            xbox.delete(multigame)
            expect(xbox.library[:games].count).to eq(0)
          end
        end
      end
    end

    context 'when content.class is App' do
      context 'when console is playstation' do
        it 'deletes app from playstation library' do
          playstation.install(app1)
          playstation.delete(app1)
          expect(playstation.library[:apps].count).to eq(0)
        end
      end

      context 'when console is xbox' do
        it 'deletes app from xbox library' do
          xbox.install(app1)
          xbox.delete(app1)
          expect(xbox.library[:apps].count).to eq(0)
        end
      end
    end
  end
end
