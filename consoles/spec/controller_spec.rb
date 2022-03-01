require_relative '../controller'
require_relative '../console'
require_relative '../xbox_controller'
require_relative '../ps_controller'
require_relative '../playstation'
require_relative '../xbox'

RSpec.describe Controller do
  let(:xbox_controller) { XboxController.new(:blue) }
  let(:ps_controller) { PSController.new(:white) }
  let(:playstation) { Playstation.new(:ps5, :home_console, :white) }
  let(:xbox) { Xbox.new(:series, :home_console, :black) }

  describe '.power_switch' do
    context 'when controller has connected console' do
      before { xbox_controller.connected_console = xbox }

      context 'when console enabled' do
        before { xbox.enabled = true }

        it 'turn on controller when it already turn off and not change connected_console.enabled' do
          xbox_controller.enabled = false
          xbox_controller.power_switch
          expect(xbox_controller.enabled).to eq(true)
          expect(xbox.enabled).to eq(true)
        end

        it 'turn off controller when it already turn on and turn off connected_console' do
          xbox_controller.enabled = true
          xbox_controller.power_switch
          expect(xbox_controller.enabled).to eq(false)
          expect(xbox.enabled).to eq(false)
        end
      end

      context 'when console disabled' do
        before { xbox.enabled = false }

        it 'turn on controller when it already turn off and turn on connected_console' do
          xbox_controller.enabled = false
          xbox_controller.power_switch
          expect(xbox_controller.enabled).to eq(true)
          expect(xbox.enabled).to eq(true)
        end

        it 'turn off controller when it already turn on and not change connected_console.enabled' do
          xbox_controller.enabled = true
          xbox_controller.power_switch
          expect(xbox_controller.enabled).to eq(false)
          expect(xbox.enabled).to eq(false)
        end
      end
    end

    context "when controller hasn't connected console" do
      it 'turn on controller when it already turn off' do
        xbox_controller.enabled = false
        xbox_controller.power_switch
        expect(xbox_controller.enabled).to eq(true)
      end

      it 'turn off controller when it already turn on' do
        xbox_controller.enabled = true
        xbox_controller.power_switch
        expect(xbox_controller.enabled).to eq(false)
      end
    end
  end

  describe '.create_console_connection' do
    context 'when controller has connected console' do
      context 'when console enabled' do
        before do
          xbox.enabled = true
          xbox_controller.connected_console = xbox
        end

        it 'changes console if connected console != new console' do
          xbox_controller.create_console_connection(xbox)
          expect(xbox_controller.connected_console).to eq(xbox)
          expect(xbox.controllers_connected).not_to include(xbox_controller)
          expect(xbox.controllers_connected).to include(xbox_controller)
        end

        it "doesn't change console if connected console == new console" do
          xbox_controller.create_console_connection(xbox)
          expect(xbox_controller.connected_console).to eq(xbox)
        end
      end
    end

    context "when controller hasn't connected console" do
      context 'when console enabled' do
        before { xbox.enabled = true }

        it 'connect controller to new console' do
          xbox_controller.create_console_connection(xbox)
          expect(xbox_controller.connected_console).to eq(xbox)
          expect(xbox.controllers_connected).to eq([xbox_controller])
        end
      end

      context 'when controller.type != console type' do
        it "doesn't connect controller to new console" do
          xbox_controller.create_console_connection(playstation)
          expect(xbox_controller.connected_console).to eq(nil)
          expect(xbox.controllers_connected).to eq([])
        end
      end
    end

    context 'when console disabled' do
      before { xbox.enabled = false }

      it 'not connect controller to new console' do
        xbox_controller.create_console_connection(xbox)
        expect(xbox_controller.connected_console).to eq(nil)
        expect(xbox.controllers_connected).to eq([])
      end
    end
  end
end
