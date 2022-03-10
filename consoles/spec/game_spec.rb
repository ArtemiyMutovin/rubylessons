require_relative '../barcode'
require_relative '../game'

RSpec.describe Game do
  let(:game) { Game.new(:batman, :action, 2014, :multi)}

  describe '.add_barcode' do
    context 'when object is console' do
      it 'adds barcode to console' do
        game.add_barcode(10)
        expect(game.barcode).to eq(10)
      end
    end
  end

  describe '.find_barcode' do
    it 'finds barcode' do
      game.add_barcode(10)
      expect(game.class.find(10)).to eq(game)
    end
  end
end

