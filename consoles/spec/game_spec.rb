require_relative '../game'

RSpec.describe Game do
  let(:game) { described_class.new(:batman, :action, 2014, :multi) }

  describe '.add_barcode' do
    it 'adds barcode to game' do
      game.add_barcode('abc-123')
      expect(game.barcode).to eq('abc-123')
    end
  end

  describe '.find_barcode' do
    it 'finds barcode' do
      game.add_barcode('abc-123')
      expect(game.class.find('abc-123')).to eq(game)
    end
  end
end
