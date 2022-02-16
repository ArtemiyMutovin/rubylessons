require_relative '../controller'
require_relative '../console'

RSpec.describe Controller do
  subject(:controller) { described_class.new(:black) }

  let(:xbox) { Console.new(:series_x, :home_console, :black) }
  let(:new_xbox) { Console.new(:series_s, :guest_console, :white) }

  describe '.power_switch' do
    context 'when controller has connected console' do
      before { controller.connected_console = xbox }

      context 'when console enabled' do
        before { xbox.enabled = true }

        it 'turn on controller when it already turn off and not change connected_console.enabled' do
          controller.enabled = false
          controller.power_switch
          expect(controller.enabled).to eq(true)
          expect(xbox.enabled).to eq(true)
        end

        it 'turn off controller when it already turn on and turn off connected_console' do
          controller.enabled = true
          controller.power_switch
          expect(controller.enabled).to eq(false)
          expect(xbox.enabled).to eq(false)
        end
      end

      context 'when console disabled' do
        before { xbox.enabled = false }

        it 'turn on controller when it already turn off and turn on connected_console' do
          controller.enabled = false
          controller.power_switch
          expect(controller.enabled).to eq(true)
          expect(xbox.enabled).to eq(true)
        end

        it 'turn off controller when it already turn on and not change connected_console.enabled' do
          controller.enabled = true
          controller.power_switch
          expect(controller.enabled).to eq(false)
          expect(xbox.enabled).to eq(false)
        end
      end
    end

    context "when controller hasn't connected console" do
      it 'turn on controller when it already turn off' do
        controller.enabled = false
        controller.power_switch
        expect(controller.enabled).to eq(true)
      end

      it 'turn off controller when it already turn on' do
        controller.enabled = true
        controller.power_switch
        expect(controller.enabled).to eq(false)
      end
    end
  end

  describe '.create_console_connection' do
    context 'when controller has connected console' do
      context 'when console enabled' do
        before do
          xbox.enabled = true
          controller.connected_console = xbox
        end

        it 'changes console if connected console != new console' do
          controller.create_console_connection(new_xbox)
          expect(controller.connected_console).to eq(new_xbox)
          expect(xbox.controllers_connected).not_to include(controller)
          expect(new_xbox.controllers_connected).to include(controller)
        end

        it "doesn't change console if connected console == new console" do
          controller.create_console_connection(xbox)
          expect(controller.connected_console).to eq(xbox)
        end
      end
    end

    context "when controller hasn't connected console" do
      context 'when console enabled' do
        before { xbox.enabled = true }

        it 'connect controller to new console' do
          controller.create_console_connection(xbox)
          expect(controller.connected_console).to eq(xbox)
          expect(xbox.controllers_connected).to eq([controller])
        end
      end

      context 'when console disabled' do
        before { xbox.enabled = false }

        it 'not connect controller to new console' do
          controller.create_console_connection(xbox)
          expect(controller.connected_console).to eq(nil)
          expect(xbox.controllers_connected).to eq([])
        end
      end
    end
  end
end
