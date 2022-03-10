require_relative '../game'

RSpec.describe Game do
  let(:game) { described_class.new(:batman, :action, 2014, :multi) }

  describe '.add_barcode' do
    it 'adds barcode to game' do
      game.add_barcode(10)
      expect(game.barcode).to eq(10)
    end
  end

  describe '.find_barcode' do
    it 'finds barcode' do
      game.add_barcode(10)
      expect(game.class.find(10)).to eq(game)
    end
  end
end
