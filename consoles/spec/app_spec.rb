require_relative '../app'

RSpec.describe App do
  let(:app) { described_class.new(:spotify) }

  describe '.add_barcode' do
    it 'adds barcode to app' do
      app.add_barcode('abc-123')
      expect(app.barcode).to eq('abc-123')
    end
  end

  describe '.find_barcode' do
    it 'finds barcode' do
      app.add_barcode('abc-123')
      expect(app.class.find('abc-123')).to eq(app)
    end
  end
end
