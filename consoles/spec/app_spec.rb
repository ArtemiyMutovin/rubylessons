require_relative '../app'

RSpec.describe App do
  let(:app) { described_class.new(:spotify) }

  describe '.add_barcode' do
    it 'adds barcode to app' do
      app.add_barcode(10)
      expect(app.barcode).to eq(10)
    end
  end

  describe '.find_barcode' do
    it 'finds barcode' do
      app.add_barcode(10)
      expect(app.class.find(10)).to eq(app)
    end
  end
end
